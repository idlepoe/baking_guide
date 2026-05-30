import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../core/utils/ingredient_category_format.dart';
import '../models/catalog_ingredient.dart';
import '../models/recipe_detail.dart';
import '../models/recipe_list_item.dart';

class RecipeRepository {
  static const _recipeListPath = 'assets/json/recipe_list.json';
  static const _recipeDetailPath = 'assets/json/recipes';

  Future<List<RecipeListItem>> loadRecipeList() async {
    try {
      final jsonString = await rootBundle.loadString(_recipeListPath);
      final list = jsonDecode(jsonString) as List<dynamic>;
      return list
          .map((e) => RecipeListItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      debugPrint('RecipeRepository.loadRecipeList failed: $e\n$stackTrace');
      return [];
    }
  }

  Future<RecipeListItem?> findRecipeListItem(String id) async {
    final list = await loadRecipeList();
    for (final item in list) {
      if (item.id == id) return item;
    }
    return null;
  }

  /// 전체 레시피 JSON에서 유니크 재료 목록 + 레시피별 재료명 목록.
  Future<
      ({
        List<CatalogIngredient> catalog,
        Map<String, List<String>> ingredientNamesByRecipeId,
      })> loadIngredientsCatalog() async {
    final list = await loadRecipeList();
    final byName = <String, CatalogIngredient>{};
    final byRecipe = <String, List<String>>{};

    for (final item in list) {
      final detail = await loadRecipeDetail(item.id);
      if (detail == null) continue;
      byRecipe[item.id] = detail.ingredients.map((ing) => ing.name).toList();
      for (final ing in detail.ingredients) {
        byName.putIfAbsent(
          ing.name,
          () => CatalogIngredient(name: ing.name, category: ing.category),
        );
      }
    }

    final catalog = byName.values.toList()
      ..sort((a, b) {
        final cat = ingredientCategorySortIndex(a.category)
            .compareTo(ingredientCategorySortIndex(b.category));
        if (cat != 0) return cat;
        return a.name.compareTo(b.name);
      });
    return (catalog: catalog, ingredientNamesByRecipeId: byRecipe);
  }

  Future<RecipeDetail?> loadRecipeDetail(String id) async {
    try {
      final jsonString =
          await rootBundle.loadString('$_recipeDetailPath/$id.json');
      return RecipeDetail.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
    } catch (e, stackTrace) {
      debugPrint(
        'RecipeRepository.loadRecipeDetail($id) failed: $e\n$stackTrace',
      );
      return null;
    }
  }
}
