import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/storage/owned_ingredient_preferences.dart';
import '../../../core/storage/recipe_bookmark_preferences.dart';
import '../../../core/storage/recipe_exam_type_filter_preferences.dart';
import '../../../core/tutorial/tutorial_guide_keys.dart';
import '../../../core/utils/ingredient_category_format.dart';
import '../../../data/models/catalog_ingredient.dart';
import '../../../data/models/enums/exam_type.dart';
import '../../../data/models/enums/ingredient_category.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../data/repositories/recipe_repository.dart';
import '../widgets/owned_ingredients_bottom_sheet.dart';

class RecipeController extends GetxController {
  RecipeController({
    RecipeRepository? repository,
    RecipeBookmarkPreferences? bookmarkPreferences,
    RecipeExamTypeFilterPreferences? examTypeFilterPreferences,
    OwnedIngredientPreferences? ownedIngredientPreferences,
  })  : _repository = repository ?? RecipeRepository(),
        _bookmarkPreferences = bookmarkPreferences ??
            (Get.isRegistered<RecipeBookmarkPreferences>()
                ? Get.find<RecipeBookmarkPreferences>()
                : RecipeBookmarkPreferences()),
        _examTypeFilterPreferences = examTypeFilterPreferences ??
            (Get.isRegistered<RecipeExamTypeFilterPreferences>()
                ? Get.find<RecipeExamTypeFilterPreferences>()
                : RecipeExamTypeFilterPreferences()),
        _ownedIngredientPreferences = ownedIngredientPreferences ??
            (Get.isRegistered<OwnedIngredientPreferences>()
                ? Get.find<OwnedIngredientPreferences>()
                : OwnedIngredientPreferences());

  final RecipeRepository _repository;
  final RecipeBookmarkPreferences _bookmarkPreferences;
  final RecipeExamTypeFilterPreferences _examTypeFilterPreferences;
  final OwnedIngredientPreferences _ownedIngredientPreferences;

  final recipes = <RecipeListItem>[].obs;
  final examTypeFilter = ExamType.baking.obs;
  final isLoading = true.obs;
  final bookmarkedRecipeIds = <String>[].obs;

  final catalogIngredients = <CatalogIngredient>[].obs;
  final ingredientNamesByRecipeId = <String, List<String>>{}.obs;
  final isCatalogLoading = false.obs;
  final checkedOwnedIngredientNames = <String>{}.obs;

  List<RecipeListItem> _allRecipes = [];
  bool _catalogLoaded = false;

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
    _bootstrapOwnedIngredients();
  }

  Future<void> _bootstrapOwnedIngredients() async {
    checkedOwnedIngredientNames.assignAll(
      await _ownedIngredientPreferences.loadCheckedNames(),
    );
    await loadOwnedIngredientsCatalog();
    if (_allRecipes.isNotEmpty) {
      _applyFilterAndSort();
    }
  }

  bool isOwnedIngredientChecked(String name) =>
      checkedOwnedIngredientNames.contains(name);

  /// 해당 레시피 배합표 재료가 보유 재료에 모두 체크되어 있으면 true.
  bool hasAllOwnedIngredientsForRecipe(String recipeId) {
    final names = ingredientNamesByRecipeId[recipeId];
    if (names == null || names.isEmpty) return false;
    return names.every(checkedOwnedIngredientNames.contains);
  }

  int get ownedIngredientUncheckedCount {
    if (catalogIngredients.isEmpty) return 0;
    return catalogIngredients
        .where((i) => !checkedOwnedIngredientNames.contains(i.name))
        .length;
  }

  bool get allOwnedIngredientsChecked {
    if (catalogIngredients.isEmpty) return false;
    return catalogIngredients.every(
      (i) => checkedOwnedIngredientNames.contains(i.name),
    );
  }

  /// category 순서대로 그룹화된 섹션 (빈 category 제외).
  List<({IngredientCategory category, List<CatalogIngredient> items})>
      get catalogByCategory {
    final map = <IngredientCategory, List<CatalogIngredient>>{};
    for (final item in catalogIngredients) {
      map.putIfAbsent(item.category, () => []).add(item);
    }
    final sections =
        <({IngredientCategory category, List<CatalogIngredient> items})>[];
    for (final category in ingredientCategorySortOrder) {
      final items = map[category];
      if (items != null && items.isNotEmpty) {
        sections.add((category: category, items: items));
      }
    }
    return sections;
  }

  Future<void> loadOwnedIngredientsCatalog() async {
    if (_catalogLoaded) return;
    isCatalogLoading.value = true;
    final data = await _repository.loadIngredientsCatalog();
    catalogIngredients.assignAll(data.catalog);
    ingredientNamesByRecipeId.assignAll(data.ingredientNamesByRecipeId);
    _catalogLoaded = true;
    isCatalogLoading.value = false;
    if (_allRecipes.isNotEmpty) {
      _applyFilterAndSort();
    }
  }

  Future<void> openOwnedIngredientsSheet(BuildContext context) async {
    await loadOwnedIngredientsCatalog();
    if (!context.mounted) return;
    OwnedIngredientsBottomSheet.show(context, this);
  }

  Future<void> toggleOwnedIngredient(String name) async {
    if (checkedOwnedIngredientNames.contains(name)) {
      checkedOwnedIngredientNames.remove(name);
    } else {
      checkedOwnedIngredientNames.add(name);
    }
    checkedOwnedIngredientNames.refresh();
    await _ownedIngredientPreferences.saveCheckedNames(
      checkedOwnedIngredientNames.toSet(),
    );
    _applyFilterAndSort();
  }

  Future<void> toggleAllOwnedIngredients() async {
    if (catalogIngredients.isEmpty) return;
    if (allOwnedIngredientsChecked) {
      checkedOwnedIngredientNames.clear();
    } else {
      checkedOwnedIngredientNames.assignAll(
        catalogIngredients.map((i) => i.name),
      );
    }
    checkedOwnedIngredientNames.refresh();
    await _ownedIngredientPreferences.saveCheckedNames(
      checkedOwnedIngredientNames.toSet(),
    );
    _applyFilterAndSort();
  }

  bool areAllOwnedIngredientsCheckedForItems(List<CatalogIngredient> items) {
    if (items.isEmpty) return false;
    return items.every(
      (item) => checkedOwnedIngredientNames.contains(item.name),
    );
  }

  Future<void> toggleCategoryOwnedIngredients(
    List<CatalogIngredient> items,
  ) async {
    if (items.isEmpty) return;
    if (areAllOwnedIngredientsCheckedForItems(items)) {
      for (final item in items) {
        checkedOwnedIngredientNames.remove(item.name);
      }
    } else {
      for (final item in items) {
        checkedOwnedIngredientNames.add(item.name);
      }
    }
    checkedOwnedIngredientNames.refresh();
    await _ownedIngredientPreferences.saveCheckedNames(
      checkedOwnedIngredientNames.toSet(),
    );
    _applyFilterAndSort();
  }

  bool isBookmarked(String recipeId) => bookmarkedRecipeIds.contains(recipeId);

  Future<void> setExamTypeFilter(ExamType examType) async {
    if (examTypeFilter.value == examType) return;
    examTypeFilter.value = examType;
    await _examTypeFilterPreferences.saveExamTypeFilter(examType);
    _applyFilterAndSort();
  }

  Future<void> toggleBookmark(String recipeId) async {
    if (isBookmarked(recipeId)) {
      bookmarkedRecipeIds.remove(recipeId);
      await _bookmarkPreferences.removeBookmark(recipeId);
    } else {
      bookmarkedRecipeIds.insert(0, recipeId);
      await _bookmarkPreferences.addBookmark(recipeId);
    }
    _applyFilterAndSort();
  }

  Future<void> loadRecipes() async {
    isLoading.value = true;
    final list = await _repository.loadRecipeList();
    final bookmarkOrder = await _bookmarkPreferences.loadBookmarkedIdsOrdered();
    final savedFilter = await _examTypeFilterPreferences.loadExamTypeFilter();

    _allRecipes = list;
    bookmarkedRecipeIds.assignAll(bookmarkOrder);
    examTypeFilter.value = savedFilter;
    _applyFilterAndSort();
    isLoading.value = false;
  }

  /// 코치마크 튜토리얼: 데모 레시피(스위트롤)가 목록에 보이도록 준비.
  Future<void> prepareForTutorialGuide() async {
    if (isLoading.value) {
      await loadRecipes();
    }
    if (examTypeFilter.value != ExamType.baking) {
      await setExamTypeFilter(ExamType.baking);
    } else {
      _applyFilterAndSort();
    }
    _pinDemoRecipeToTop();
  }

  /// 튜토리얼 종료 후 즐겨찾기·재료 정렬 복원.
  void restoreDefaultSort() {
    _applyFilterAndSort();
  }

  void _pinDemoRecipeToTop() {
    final demoId = TutorialGuideKeys.demoRecipeId;
    final demo = recipes.firstWhereOrNull((r) => r.id == demoId);
    if (demo == null) return;
    if (recipes.isNotEmpty && recipes.first.id == demoId) return;
    final rest = recipes.where((r) => r.id != demoId).toList();
    recipes.assignAll([demo, ...rest]);
  }

  void _applyFilterAndSort() {
    final filtered = _allRecipes
        .where((recipe) => recipe.examType == examTypeFilter.value)
        .toList();
    recipes.assignAll(
      _sortByBookmarkAndOwnedIngredients(filtered, bookmarkedRecipeIds),
    );
  }

  /// 즐겨찾기 순 → 나머지는「재료 있음」레시피 우선(원본 목록 순서 유지).
  List<RecipeListItem> _sortByBookmarkAndOwnedIngredients(
    List<RecipeListItem> all,
    List<String> bookmarkOrder,
  ) {
    if (all.isEmpty) return all;

    final bookmarkSet = bookmarkOrder.toSet();
    final byId = {for (final recipe in all) recipe.id: recipe};
    final bookmarked = <RecipeListItem>[];

    for (final id in bookmarkOrder) {
      final recipe = byId[id];
      if (recipe != null) bookmarked.add(recipe);
    }

    final indexInAll = {for (var i = 0; i < all.length; i++) all[i].id: i};
    final rest = all.where((r) => !bookmarkSet.contains(r.id)).toList()
      ..sort((a, b) {
        final aOwned = hasAllOwnedIngredientsForRecipe(a.id);
        final bOwned = hasAllOwnedIngredientsForRecipe(b.id);
        if (aOwned != bOwned) return aOwned ? -1 : 1;
        return indexInAll[a.id]!.compareTo(indexInAll[b.id]!);
      });

    return [...bookmarked, ...rest];
  }
}
