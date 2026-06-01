// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_note_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyNoteSection _$StudyNoteSectionFromJson(Map<String, dynamic> json) =>
    _StudyNoteSection(
      title: json['title'] as String,
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$StudyNoteSectionToJson(_StudyNoteSection instance) =>
    <String, dynamic>{'title': instance.title, 'items': instance.items};
