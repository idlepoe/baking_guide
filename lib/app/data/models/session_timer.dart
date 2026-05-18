import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/timer_kind.dart';

part 'session_timer.freezed.dart';
part 'session_timer.g.dart';

/// 진행 세션에서 실행 중이거나 일시정지된 타이머 상태.
@freezed
abstract class SessionTimer with _$SessionTimer {
  const factory SessionTimer({
    required TimerKind type,
    required String label,
    required int durationSec,
    String? startedAt,
    @Default(0) int elapsedSec,
  }) = _SessionTimer;

  factory SessionTimer.fromJson(Map<String, dynamic> json) =>
      _$SessionTimerFromJson(json);
}
