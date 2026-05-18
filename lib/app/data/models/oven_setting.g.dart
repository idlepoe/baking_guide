// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oven_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OvenSetting _$OvenSettingFromJson(Map<String, dynamic> json) => _OvenSetting(
  top: (json['top'] as num).toInt(),
  bottom: (json['bottom'] as num).toInt(),
  unit:
      $enumDecodeNullable(_$TemperatureUnitEnumMap, json['unit']) ??
      TemperatureUnit.celsius,
);

Map<String, dynamic> _$OvenSettingToJson(_OvenSetting instance) =>
    <String, dynamic>{
      'top': instance.top,
      'bottom': instance.bottom,
      'unit': _$TemperatureUnitEnumMap[instance.unit]!,
    };

const _$TemperatureUnitEnumMap = {
  TemperatureUnit.celsius: 'celsius',
  TemperatureUnit.fahrenheit: 'fahrenheit',
};
