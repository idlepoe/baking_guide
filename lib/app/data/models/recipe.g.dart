// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recipe _$RecipeFromJson(Map<String, dynamic> json) => _Recipe(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
  difficulty: (json['difficulty'] as num).toInt(),
  totalTimeSec: (json['totalTimeSec'] as num).toInt(),
);

Map<String, dynamic> _$RecipeToJson(_Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'thumbnailUrl': instance.thumbnailUrl,
  'difficulty': instance.difficulty,
  'totalTimeSec': instance.totalTimeSec,
};
