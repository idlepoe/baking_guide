import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/calculator_kind.dart';

part 'calculator_config.freezed.dart';
part 'calculator_config.g.dart';

@freezed
abstract class CalculatorConfig with _$CalculatorConfig {
  const factory CalculatorConfig({
    required CalculatorKind type,
  }) = _CalculatorConfig;

  factory CalculatorConfig.fromJson(Map<String, dynamic> json) =>
      _$CalculatorConfigFromJson(json);
}
