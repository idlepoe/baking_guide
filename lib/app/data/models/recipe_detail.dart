import 'package:freezed_annotation/freezed_annotation.dart';

import 'evaluation_criterion.dart';
import 'recipe_ingredient.dart';
import 'recipe_step.dart';
import 'recipe_summary.dart';

part 'recipe_detail.freezed.dart';
part 'recipe_detail.g.dart';

@freezed
abstract class RecipeDetail with _$RecipeDetail {
  const factory RecipeDetail({
    required String id,
    required String name,
    required String category,
    @Default('') String thumbnailUrl,
    required RecipeSummary summary,
    @Default([]) List<RecipeIngredient> ingredients,
    @Default([]) List<RecipeStep> steps,
    @Default([]) List<EvaluationCriterion> resultEvaluation,
  }) = _RecipeDetail;

  factory RecipeDetail.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailFromJson(json);
}
