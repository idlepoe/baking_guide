import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum MixingMethod {
  @JsonValue('straight')
  straight,
  @JsonValue('sponge')
  sponge,
  @JsonValue('modified_straight')
  modifiedStraight,
  @JsonValue('emergency_straight')
  emergencyStraight,
  @JsonValue('cream')
  cream,
  @JsonValue('separated_egg')
  separatedEgg,
  @JsonValue('chiffon')
  chiffon,
  @JsonValue('meringue')
  meringue,
  @JsonValue('one_stage')
  oneStage,
  @JsonValue('choux')
  choux,
  @JsonValue('blending')
  blending,
}
