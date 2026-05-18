// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_point_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KeyPointGroup _$KeyPointGroupFromJson(Map<String, dynamic> json) =>
    _KeyPointGroup(
      title: json['title'] as String,
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$KeyPointGroupToJson(_KeyPointGroup instance) =>
    <String, dynamic>{'title': instance.title, 'items': instance.items};
