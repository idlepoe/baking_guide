// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StepImage _$StepImageFromJson(Map<String, dynamic> json) => _StepImage(
  type: $enumDecode(_$StepImageTypeEnumMap, json['type']),
  title: json['title'] as String,
  imageUrl: json['imageUrl'] as String? ?? '',
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$StepImageToJson(_StepImage instance) =>
    <String, dynamic>{
      'type': _$StepImageTypeEnumMap[instance.type]!,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };

const _$StepImageTypeEnumMap = {
  StepImageType.normal: 'normal',
  StepImageType.fail: 'fail',
  StepImageType.compare: 'compare',
};
