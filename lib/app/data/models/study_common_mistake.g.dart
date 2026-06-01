// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_common_mistake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyCommonMistake _$StudyCommonMistakeFromJson(Map<String, dynamic> json) =>
    _StudyCommonMistake(
      severity: $enumDecode(_$DeductionSeverityEnumMap, json['severity']),
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$StudyCommonMistakeToJson(_StudyCommonMistake instance) =>
    <String, dynamic>{
      'severity': _$DeductionSeverityEnumMap[instance.severity]!,
      'title': instance.title,
      'description': instance.description,
    };

const _$DeductionSeverityEnumMap = {
  DeductionSeverity.low: 'low',
  DeductionSeverity.medium: 'medium',
  DeductionSeverity.high: 'high',
};
