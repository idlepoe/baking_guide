// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressSession _$ProgressSessionFromJson(
  Map<String, dynamic> json,
) => _ProgressSession(
  sessionId: json['sessionId'] as String,
  recipeId: json['recipeId'] as String,
  status: $enumDecode(_$ProgressSessionStatusEnumMap, json['status']),
  startedAt: const IsoDateTimeConverter().fromJson(json['startedAt'] as String),
  updatedAt: const IsoDateTimeConverter().fromJson(json['updatedAt'] as String),
  completedAt: _$JsonConverterFromJson<String, DateTime>(
    json['completedAt'],
    const IsoDateTimeConverter().fromJson,
  ),
  currentStepNo: (json['currentStepNo'] as num).toInt(),
  completedSteps:
      (json['completedSteps'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => StepProgress.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ProgressSessionToJson(_ProgressSession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'recipeId': instance.recipeId,
      'status': _$ProgressSessionStatusEnumMap[instance.status]!,
      'startedAt': const IsoDateTimeConverter().toJson(instance.startedAt),
      'updatedAt': const IsoDateTimeConverter().toJson(instance.updatedAt),
      'completedAt': _$JsonConverterToJson<String, DateTime>(
        instance.completedAt,
        const IsoDateTimeConverter().toJson,
      ),
      'currentStepNo': instance.currentStepNo,
      'completedSteps': instance.completedSteps,
      'steps': instance.steps,
    };

const _$ProgressSessionStatusEnumMap = {
  ProgressSessionStatus.ready: 'ready',
  ProgressSessionStatus.inProgress: 'in_progress',
  ProgressSessionStatus.completed: 'completed',
  ProgressSessionStatus.abandoned: 'abandoned',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
