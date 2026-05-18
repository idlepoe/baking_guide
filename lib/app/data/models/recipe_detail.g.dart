// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeDetail _$RecipeDetailFromJson(Map<String, dynamic> json) =>
    _RecipeDetail(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      summary: RecipeSummary.fromJson(json['summary'] as Map<String, dynamic>),
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      resultEvaluation:
          (json['resultEvaluation'] as List<dynamic>?)
              ?.map(
                (e) => EvaluationCriterion.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RecipeDetailToJson(_RecipeDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'thumbnailUrl': instance.thumbnailUrl,
      'summary': instance.summary,
      'steps': instance.steps,
      'resultEvaluation': instance.resultEvaluation,
    };
