import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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
