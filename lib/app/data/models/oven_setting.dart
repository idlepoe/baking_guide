import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/temperature_unit.dart';

part 'oven_setting.freezed.dart';
part 'oven_setting.g.dart';

@freezed
abstract class OvenSetting with _$OvenSetting {
  const factory OvenSetting({
    required int top,
    required int bottom,
    @Default(TemperatureUnit.celsius) TemperatureUnit unit,
  }) = _OvenSetting;

  factory OvenSetting.fromJson(Map<String, dynamic> json) =>
      _$OvenSettingFromJson(json);
}
