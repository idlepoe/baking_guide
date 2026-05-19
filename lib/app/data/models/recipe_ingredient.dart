import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/ingredient_category.dart';

part 'recipe_ingredient.freezed.dart';
part 'recipe_ingredient.g.dart';

@freezed
abstract class RecipeIngredient with _$RecipeIngredient {
  const factory RecipeIngredient({
    required String name,
    required num amount,
    required String unit,
    required IngredientCategory category,
    @Default(true) bool required,
    num? maxAmount,
  }) = _RecipeIngredient;

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientFromJson(json);
}
