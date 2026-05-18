import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum StepImageType {
  @JsonValue('normal')
  normal,
  @JsonValue('fail')
  fail,
  @JsonValue('compare')
  compare,
}
