import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum MixingMethod {
  @JsonValue('straight')
  straight,
  @JsonValue('sponge')
  sponge,
  @JsonValue('modified_straight')
  modifiedStraight,
}
