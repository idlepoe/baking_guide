import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/timer_kind.dart';

part 'step_timer.freezed.dart';
part 'step_timer.g.dart';

@freezed
abstract class StepTimer with _$StepTimer {
  const factory StepTimer({
    required TimerKind type,
    required String label,
    required int durationSec,
  }) = _StepTimer;

  factory StepTimer.fromJson(Map<String, dynamic> json) =>
      _$StepTimerFromJson(json);
}
