import 'package:get/get.dart';

import '../../../core/storage/recipe_bookmark_preferences.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../data/repositories/recipe_repository.dart';

class RecipeController extends GetxController {
  RecipeController({
    RecipeRepository? repository,
    RecipeBookmarkPreferences? bookmarkPreferences,
  })  : _repository = repository ?? RecipeRepository(),
        _bookmarkPreferences = bookmarkPreferences ??
            (Get.isRegistered<RecipeBookmarkPreferences>()
                ? Get.find<RecipeBookmarkPreferences>()
                : RecipeBookmarkPreferences());

  final RecipeRepository _repository;
  final RecipeBookmarkPreferences _bookmarkPreferences;

  final recipes = <RecipeListItem>[].obs;
  final isLoading = true.obs;
  final bookmarkedRecipeIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
  }

  bool isBookmarked(String recipeId) => bookmarkedRecipeIds.contains(recipeId);

  Future<void> toggleBookmark(String recipeId) async {
    if (isBookmarked(recipeId)) {
      bookmarkedRecipeIds.remove(recipeId);
      await _bookmarkPreferences.removeBookmark(recipeId);
    } else {
      bookmarkedRecipeIds.insert(0, recipeId);
      await _bookmarkPreferences.addBookmark(recipeId);
    }
    _reorderRecipes();
  }

  Future<void> loadRecipes() async {
    isLoading.value = true;
    final list = await _repository.loadRecipeList();
    final bookmarkOrder = await _bookmarkPreferences.loadBookmarkedIdsOrdered();
    bookmarkedRecipeIds.assignAll(bookmarkOrder);
    recipes.assignAll(_sortByBookmarkOrder(list, bookmarkOrder));
    isLoading.value = false;
  }

  void _reorderRecipes() {
    recipes.assignAll(
      _sortByBookmarkOrder(List<RecipeListItem>.from(recipes), bookmarkedRecipeIds),
    );
  }

  List<RecipeListItem> _sortByBookmarkOrder(
    List<RecipeListItem> all,
    List<String> bookmarkOrder,
  ) {
    if (bookmarkOrder.isEmpty) return all;

    final bookmarkSet = bookmarkOrder.toSet();
    final byId = {for (final recipe in all) recipe.id: recipe};
    final bookmarked = <RecipeListItem>[];

    for (final id in bookmarkOrder) {
      final recipe = byId[id];
      if (recipe != null) bookmarked.add(recipe);
    }

    final rest = all.where((r) => !bookmarkSet.contains(r.id)).toList();
    return [...bookmarked, ...rest];
  }
}
