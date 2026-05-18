import 'package:freezed_annotation/freezed_annotation.dart';

import 'session_timer.dart';

part 'progress_session.freezed.dart';
part 'progress_session.g.dart';

@freezed
abstract class ProgressSession with _$ProgressSession {
  const factory ProgressSession({
    required String sessionId,
    required String recipeId,
    required int currentStep,
    @Default([]) List<String> checkedItems,
    @Default('') String startedAt,
    @Default([]) List<SessionTimer> timers,
  }) = _ProgressSession;

  factory ProgressSession.fromJson(Map<String, dynamic> json) =>
      _$ProgressSessionFromJson(json);
}
