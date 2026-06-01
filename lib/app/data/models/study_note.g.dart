// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyNote _$StudyNoteFromJson(Map<String, dynamic> json) => _StudyNote(
  id: json['id'] as String,
  sections:
      (json['sections'] as List<dynamic>?)
          ?.map((e) => StudyNoteSection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  commonMistakes:
      (json['commonMistakes'] as List<dynamic>?)
          ?.map((e) => StudyCommonMistake.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => StudyNoteImage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  flow:
      (json['flow'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  flashcards:
      (json['flashcards'] as List<dynamic>?)
          ?.map((e) => StudyNoteFlashcard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$StudyNoteToJson(_StudyNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sections': instance.sections,
      'commonMistakes': instance.commonMistakes,
      'images': instance.images,
      'flow': instance.flow,
      'flashcards': instance.flashcards,
    };
