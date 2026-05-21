import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum IngredientCategory {
  @JsonValue('flour')
  flour,
  @JsonValue('liquid')
  liquid,
  @JsonValue('sweetener')
  sweetener,
  @JsonValue('salt')
  salt,
  @JsonValue('yeast')
  yeast,
  @JsonValue('fat')
  fat,
  @JsonValue('filling')
  filling,
  @JsonValue('improver')
  improver,
  @JsonValue('liquid_optional')
  liquidOptional,
  @JsonValue('powder')
  powder,
  @JsonValue('egg')
  egg,
  @JsonValue('spice')
  spice,
}
