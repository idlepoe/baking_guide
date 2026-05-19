import 'package:json_annotation/json_annotation.dart';

class IsoDateTimeConverter implements JsonConverter<DateTime, String> {
  const IsoDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal();

  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}
