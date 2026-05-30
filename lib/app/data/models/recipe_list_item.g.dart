// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeListItem _$RecipeListItemFromJson(Map<String, dynamic> json) =>
    _RecipeListItem(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      examType:
          $enumDecodeNullable(_$ExamTypeEnumMap, json['examType']) ??
          ExamType.baking,
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      difficulty: (json['difficulty'] as num).toInt(),
      totalTimeSec: (json['totalTimeSec'] as num).toInt(),
    );

Map<String, dynamic> _$RecipeListItemToJson(_RecipeListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'examType': _$ExamTypeEnumMap[instance.examType]!,
      'thumbnailUrl': instance.thumbnailUrl,
      'difficulty': instance.difficulty,
      'totalTimeSec': instance.totalTimeSec,
    };

const _$ExamTypeEnumMap = {
  ExamType.baking: 'baking',
  ExamType.confectionery: 'confectionery',
};
