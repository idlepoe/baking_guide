// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeductionPoint _$DeductionPointFromJson(Map<String, dynamic> json) =>
    _DeductionPoint(
      severity: $enumDecode(_$DeductionSeverityEnumMap, json['severity']),
      text: json['text'] as String,
    );

Map<String, dynamic> _$DeductionPointToJson(_DeductionPoint instance) =>
    <String, dynamic>{
      'severity': _$DeductionSeverityEnumMap[instance.severity]!,
      'text': instance.text,
    };

const _$DeductionSeverityEnumMap = {
  DeductionSeverity.low: 'low',
  DeductionSeverity.medium: 'medium',
  DeductionSeverity.high: 'high',
};
