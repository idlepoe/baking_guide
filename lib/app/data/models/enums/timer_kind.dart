import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TimerKind {
  @JsonValue('exam')
  exam,
  @JsonValue('step')
  step,
  @JsonValue('fermentation')
  fermentation,
  @JsonValue('rest')
  rest,
  @JsonValue('proofing')
  proofing,
  @JsonValue('baking')
  baking,
}
