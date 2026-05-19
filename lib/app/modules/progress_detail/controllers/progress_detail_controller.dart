import 'package:get/get.dart';

import '../../../data/models/recipe_detail.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../data/models/recipe_step.dart';
import '../../../data/repositories/recipe_repository.dart';
import '../../../routes/app_pages.dart';

class ProgressDetailController extends GetxController {
  ProgressDetailController({
    required this.recipeId,
    RecipeRepository? repository,
  }) : _repository = repository ?? RecipeRepository();

  final String recipeId;
  final RecipeRepository _repository;

  final isLoading = true.obs;
  final hasError = false.obs;
  final recipe = Rxn<RecipeDetail>();
  final recipeListItem = Rxn<RecipeListItem>();
  final currentStepIndex = 0.obs;
  final checkedItemIds = <String>{}.obs;
  final checkedIngredientIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (recipeId.isEmpty) {
      _handleLoadFailure('레시피 정보가 없습니다.');
      return;
    }
    _loadRecipe();
  }

  RecipeStep? get currentStep {
    final detail = recipe.value;
    if (detail == null || detail.steps.isEmpty) return null;
    final index = currentStepIndex.value;
    if (index < 0 || index >= detail.steps.length) return null;
    return detail.steps[index];
  }

  bool get canGoPrevious => currentStepIndex.value > 0;

  bool get canGoNext {
    final detail = recipe.value;
    if (detail == null || detail.steps.isEmpty) return false;
    return currentStepIndex.value < detail.steps.length - 1;
  }

  int get checkedCountForCurrentStep {
    final step = currentStep;
    if (step == null) return 0;
    return step.checklist
        .where((item) => checkedItemIds.contains(item.id))
        .length;
  }

  Future<void> _loadRecipe() async {
    isLoading.value = true;
    hasError.value = false;

    final detail = await _repository.loadRecipeDetail(recipeId);
    if (detail == null || detail.steps.isEmpty) {
      _handleLoadFailure('레시피를 불러올 수 없습니다.');
      return;
    }

    recipeListItem.value = await _repository.findRecipeListItem(recipeId);
    recipe.value = detail;
    isLoading.value = false;
  }

  void _handleLoadFailure(String message) {
    isLoading.value = false;
    hasError.value = true;
    Get.snackbar('오류', message);
    Future.microtask(() => Get.offAllNamed(Routes.HOME));
  }

  void goToPreviousStep() {
    if (!canGoPrevious) return;
    currentStepIndex.value--;
  }

  void goToNextStep() {
    if (!canGoNext) return;
    currentStepIndex.value++;
  }

  void goToStep(int index) {
    final detail = recipe.value;
    if (detail == null) return;
    if (index < 0 || index >= detail.steps.length) return;
    currentStepIndex.value = index;
  }

  bool isChecked(String id) => checkedItemIds.contains(id);

  void toggleChecklist(String id) {
    if (checkedItemIds.contains(id)) {
      checkedItemIds.remove(id);
    } else {
      checkedItemIds.add(id);
    }
    checkedItemIds.refresh();
  }

  void toggleIngredient(String name) {
    if (checkedIngredientIds.contains(name)) {
      checkedIngredientIds.remove(name);
    } else {
      checkedIngredientIds.add(name);
    }
    checkedIngredientIds.refresh();
  }

  /// JSON 스텝의 [RecipeStep.imageUrl] (비어 있으면 null).
  String? stepImageUrl(RecipeStep step) {
    final url = step.imageUrl.trim();
    if (url.isEmpty) return null;
    return url;
  }
}
