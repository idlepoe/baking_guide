import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum DeductionSeverity {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
}
