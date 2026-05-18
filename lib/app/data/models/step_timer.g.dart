// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StepTimer _$StepTimerFromJson(Map<String, dynamic> json) => _StepTimer(
  type: $enumDecode(_$TimerKindEnumMap, json['type']),
  label: json['label'] as String,
  durationSec: (json['durationSec'] as num).toInt(),
);

Map<String, dynamic> _$StepTimerToJson(_StepTimer instance) =>
    <String, dynamic>{
      'type': _$TimerKindEnumMap[instance.type]!,
      'label': instance.label,
      'durationSec': instance.durationSec,
    };

const _$TimerKindEnumMap = {
  TimerKind.exam: 'exam',
  TimerKind.step: 'step',
  TimerKind.fermentation: 'fermentation',
};
