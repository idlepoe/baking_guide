import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TimerKind {
  @JsonValue('exam')
  exam,
  @JsonValue('step')
  step,
  @JsonValue('fermentation')
  fermentation,
}
