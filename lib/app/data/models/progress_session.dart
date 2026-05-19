import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/progress_session_status.dart';

part 'progress_session.freezed.dart';
part 'progress_session.g.dart';

class IsoDateTimeConverter implements JsonConverter<DateTime, String> {
  const IsoDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal();

  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}

@freezed
abstract class ProgressSession with _$ProgressSession {
  const factory ProgressSession({
    required String sessionId,
    required String recipeId,
    required ProgressSessionStatus status,
    @IsoDateTimeConverter() required DateTime startedAt,
    @IsoDateTimeConverter() required DateTime updatedAt,
    @IsoDateTimeConverter() DateTime? completedAt,
    required int currentStepNo,
    @Default([]) List<int> completedSteps,
  }) = _ProgressSession;

  factory ProgressSession.fromJson(Map<String, dynamic> json) =>
      _$ProgressSessionFromJson(json);
}
