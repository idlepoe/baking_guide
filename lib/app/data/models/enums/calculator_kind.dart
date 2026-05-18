import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum CalculatorKind {
  @JsonValue('dough_temp')
  doughTemp,
  @JsonValue('division_weight')
  divisionWeight,
  @JsonValue('baker_percentage')
  bakerPercentage,
}
