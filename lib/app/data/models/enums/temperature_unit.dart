import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TemperatureUnit {
  @JsonValue('celsius')
  celsius,
  @JsonValue('fahrenheit')
  fahrenheit,
}
