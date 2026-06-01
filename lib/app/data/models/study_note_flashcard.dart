import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_note_flashcard.freezed.dart';
part 'study_note_flashcard.g.dart';

@freezed
abstract class StudyNoteFlashcard with _$StudyNoteFlashcard {
  const factory StudyNoteFlashcard({
    required String question,
    required String answer,
  }) = _StudyNoteFlashcard;

  factory StudyNoteFlashcard.fromJson(Map<String, dynamic> json) =>
      _$StudyNoteFlashcardFromJson(json);
}
