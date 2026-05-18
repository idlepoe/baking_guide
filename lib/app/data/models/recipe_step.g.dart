// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeStep _$RecipeStepFromJson(Map<String, dynamic> json) => _RecipeStep(
  stepNo: (json['stepNo'] as num).toInt(),
  title: json['title'] as String,
  estimatedTimeSec: (json['estimatedTimeSec'] as num?)?.toInt() ?? 0,
  imageUrl: json['imageUrl'] as String? ?? '',
  description:
      (json['description'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  tips:
      (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  checklist:
      (json['checklist'] as List<dynamic>?)
          ?.map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  deductionPoints:
      (json['deductionPoints'] as List<dynamic>?)
          ?.map((e) => DeductionPoint.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  timers:
      (json['timers'] as List<dynamic>?)
          ?.map((e) => StepTimer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  calculators:
      (json['calculators'] as List<dynamic>?)
          ?.map((e) => CalculatorConfig.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => StepImage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$RecipeStepToJson(_RecipeStep instance) =>
    <String, dynamic>{
      'stepNo': instance.stepNo,
      'title': instance.title,
      'estimatedTimeSec': instance.estimatedTimeSec,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'tips': instance.tips,
      'checklist': instance.checklist,
      'deductionPoints': instance.deductionPoints,
      'timers': instance.timers,
      'calculators': instance.calculators,
      'images': instance.images,
    };
