// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionTimer _$SessionTimerFromJson(Map<String, dynamic> json) =>
    _SessionTimer(
      type: $enumDecode(_$TimerKindEnumMap, json['type']),
      label: json['label'] as String,
      durationSec: (json['durationSec'] as num).toInt(),
      startedAt: json['startedAt'] as String?,
      elapsedSec: (json['elapsedSec'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SessionTimerToJson(_SessionTimer instance) =>
    <String, dynamic>{
      'type': _$TimerKindEnumMap[instance.type]!,
      'label': instance.label,
      'durationSec': instance.durationSec,
      'startedAt': instance.startedAt,
      'elapsedSec': instance.elapsedSec,
    };

const _$TimerKindEnumMap = {
  TimerKind.exam: 'exam',
  TimerKind.step: 'step',
  TimerKind.fermentation: 'fermentation',
};
