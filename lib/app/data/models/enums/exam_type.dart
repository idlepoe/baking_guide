import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ExamType {
  @JsonValue('baking')
  baking,
  @JsonValue('confectionery')
  confectionery,
}
