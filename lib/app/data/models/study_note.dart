import 'package:freezed_annotation/freezed_annotation.dart';

import 'study_common_mistake.dart';
import 'study_note_flashcard.dart';
import 'study_note_image.dart';
import 'study_note_section.dart';

part 'study_note.freezed.dart';
part 'study_note.g.dart';

/// `studies/{id}.json` 항목 — 품목별 핵심노트(섹션, 흔한 실수, 플로우, 플래시카드 등).
@freezed
abstract class StudyNote with _$StudyNote {
  const factory StudyNote({
    required String id,
    @Default([]) List<StudyNoteSection> sections,
    @Default([]) List<StudyCommonMistake> commonMistakes,
    @Default([]) List<StudyNoteImage> images,
    @Default([]) List<String> flow,
    @Default([]) List<StudyNoteFlashcard> flashcards,
  }) = _StudyNote;

  factory StudyNote.fromJson(Map<String, dynamic> json) =>
      _$StudyNoteFromJson(json);
}
