// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalculatorConfig _$CalculatorConfigFromJson(Map<String, dynamic> json) =>
    _CalculatorConfig(type: $enumDecode(_$CalculatorKindEnumMap, json['type']));

Map<String, dynamic> _$CalculatorConfigToJson(_CalculatorConfig instance) =>
    <String, dynamic>{'type': _$CalculatorKindEnumMap[instance.type]!};

const _$CalculatorKindEnumMap = {
  CalculatorKind.doughTemp: 'dough_temp',
  CalculatorKind.divisionWeight: 'division_weight',
  CalculatorKind.bakerPercentage: 'baker_percentage',
};
