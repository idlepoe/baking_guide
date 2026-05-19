// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StepProgress _$StepProgressFromJson(Map<String, dynamic> json) =>
    _StepProgress(
      stepNo: (json['stepNo'] as num).toInt(),
      startedAt: const IsoDateTimeConverter().fromJson(
        json['startedAt'] as String,
      ),
    );

Map<String, dynamic> _$StepProgressToJson(_StepProgress instance) =>
    <String, dynamic>{
      'stepNo': instance.stepNo,
      'startedAt': const IsoDateTimeConverter().toJson(instance.startedAt),
    };
