import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/progress_session_status.dart';
import 'iso_datetime_converter.dart';
import 'step_progress.dart';

part 'progress_session.freezed.dart';
part 'progress_session.g.dart';

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
    @Default([]) List<StepProgress> steps,
  }) = _ProgressSession;

  factory ProgressSession.fromJson(Map<String, dynamic> json) =>
      _$ProgressSessionFromJson(json);
}
