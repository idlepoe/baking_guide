import 'package:get/get.dart';

import '../../../data/models/recipe_list_item.dart';
import '../../../data/repositories/recipe_repository.dart';

class RecipeController extends GetxController {
  RecipeController({RecipeRepository? repository})
      : _repository = repository ?? RecipeRepository();

  final RecipeRepository _repository;

  final recipes = <RecipeListItem>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    isLoading.value = true;
    recipes.assignAll(await _repository.loadRecipeList());
    isLoading.value = false;
  }
}
