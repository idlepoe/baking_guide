// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeSummary _$RecipeSummaryFromJson(Map<String, dynamic> json) =>
    _RecipeSummary(
      examTimeSec: (json['examTimeSec'] as num).toInt(),
      mixingMethod: $enumDecode(_$MixingMethodEnumMap, json['mixingMethod']),
      oven: OvenSetting.fromJson(json['oven'] as Map<String, dynamic>),
      keyPoints:
          (json['keyPoints'] as List<dynamic>?)
              ?.map((e) => KeyPointGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RecipeSummaryToJson(_RecipeSummary instance) =>
    <String, dynamic>{
      'examTimeSec': instance.examTimeSec,
      'mixingMethod': _$MixingMethodEnumMap[instance.mixingMethod]!,
      'oven': instance.oven,
      'keyPoints': instance.keyPoints,
    };

const _$MixingMethodEnumMap = {
  MixingMethod.straight: 'straight',
  MixingMethod.sponge: 'sponge',
  MixingMethod.modifiedStraight: 'modified_straight',
  MixingMethod.emergencyStraight: 'emergency_straight',
  MixingMethod.cream: 'cream',
  MixingMethod.separatedEgg: 'separated_egg',
  MixingMethod.chiffon: 'chiffon',
  MixingMethod.meringue: 'meringue',
  MixingMethod.oneStage: 'one_stage',
  MixingMethod.choux: 'choux',
  MixingMethod.blending: 'blending',
};
