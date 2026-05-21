import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator_params.freezed.dart';
part 'calculator_params.g.dart';

@freezed
abstract class CalculatorParams with _$CalculatorParams {
  const factory CalculatorParams({
    num? target,
  }) = _CalculatorParams;

  factory CalculatorParams.fromJson(Map<String, dynamic> json) =>
      _$CalculatorParamsFromJson(json);
}
