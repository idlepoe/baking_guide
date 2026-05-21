// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalculatorConfig _$CalculatorConfigFromJson(Map<String, dynamic> json) =>
    _CalculatorConfig(
      type: $enumDecode(_$CalculatorKindEnumMap, json['type']),
      params: json['params'] == null
          ? const CalculatorParams()
          : CalculatorParams.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CalculatorConfigToJson(_CalculatorConfig instance) =>
    <String, dynamic>{
      'type': _$CalculatorKindEnumMap[instance.type]!,
      'params': instance.params,
    };

const _$CalculatorKindEnumMap = {
  CalculatorKind.doughTemp: 'dough_temp',
  CalculatorKind.divisionWeight: 'division_weight',
  CalculatorKind.bakerPercentage: 'baker_percentage',
};
