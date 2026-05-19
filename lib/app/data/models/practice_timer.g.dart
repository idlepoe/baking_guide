// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PracticeTimer _$PracticeTimerFromJson(Map<String, dynamic> json) =>
    _PracticeTimer(
      timerId: json['timerId'] as String,
      sessionId: json['sessionId'] as String,
      type: $enumDecode(_$TimerKindEnumMap, json['type']),
      durationSec: (json['durationSec'] as num).toInt(),
      startedAt: const IsoDateTimeConverter().fromJson(
        json['startedAt'] as String,
      ),
      endsAt: const IsoDateTimeConverter().fromJson(json['endsAt'] as String),
      notificationEnabled: json['notificationEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$PracticeTimerToJson(_PracticeTimer instance) =>
    <String, dynamic>{
      'timerId': instance.timerId,
      'sessionId': instance.sessionId,
      'type': _$TimerKindEnumMap[instance.type]!,
      'durationSec': instance.durationSec,
      'startedAt': const IsoDateTimeConverter().toJson(instance.startedAt),
      'endsAt': const IsoDateTimeConverter().toJson(instance.endsAt),
      'notificationEnabled': instance.notificationEnabled,
    };

const _$TimerKindEnumMap = {
  TimerKind.exam: 'exam',
  TimerKind.step: 'step',
  TimerKind.fermentation: 'fermentation',
};
