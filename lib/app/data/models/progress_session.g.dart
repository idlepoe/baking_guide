// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressSession _$ProgressSessionFromJson(Map<String, dynamic> json) =>
    _ProgressSession(
      sessionId: json['sessionId'] as String,
      recipeId: json['recipeId'] as String,
      currentStep: (json['currentStep'] as num).toInt(),
      checkedItems:
          (json['checkedItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startedAt: json['startedAt'] as String? ?? '',
      timers:
          (json['timers'] as List<dynamic>?)
              ?.map((e) => SessionTimer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProgressSessionToJson(_ProgressSession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'recipeId': instance.recipeId,
      'currentStep': instance.currentStep,
      'checkedItems': instance.checkedItems,
      'startedAt': instance.startedAt,
      'timers': instance.timers,
    };
