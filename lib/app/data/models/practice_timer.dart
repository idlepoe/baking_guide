import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/timer_kind.dart';
import 'iso_datetime_converter.dart';

part 'practice_timer.freezed.dart';
part 'practice_timer.g.dart';

@freezed
abstract class PracticeTimer with _$PracticeTimer {
  const factory PracticeTimer({
    required String timerId,
    required String sessionId,
    required TimerKind type,
    required int durationSec,
    @IsoDateTimeConverter() required DateTime startedAt,
    @IsoDateTimeConverter() required DateTime endsAt,
    @Default(true) bool notificationEnabled,
  }) = _PracticeTimer;

  factory PracticeTimer.fromJson(Map<String, dynamic> json) =>
      _$PracticeTimerFromJson(json);
}

extension PracticeTimerX on PracticeTimer {
  bool get isActive => endsAt.isAfter(DateTime.now());
}
