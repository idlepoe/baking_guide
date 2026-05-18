// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Step _$StepFromJson(Map<String, dynamic> json) => _Step(
  stepNo: (json['stepNo'] as num).toInt(),
  title: json['title'] as String,
  estimatedTimeSec: (json['estimatedTimeSec'] as num).toInt(),
  description:
      (json['description'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => StepImage.fromJson(e as Map<String, dynamic>))
          .toList() ??
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
);

Map<String, dynamic> _$StepToJson(_Step instance) => <String, dynamic>{
  'stepNo': instance.stepNo,
  'title': instance.title,
  'estimatedTimeSec': instance.estimatedTimeSec,
  'description': instance.description,
  'images': instance.images,
  'checklist': instance.checklist,
  'deductionPoints': instance.deductionPoints,
  'timers': instance.timers,
  'calculators': instance.calculators,
};
