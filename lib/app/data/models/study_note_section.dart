import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_note_section.freezed.dart';
part 'study_note_section.g.dart';

@freezed
abstract class StudyNoteSection with _$StudyNoteSection {
  const factory StudyNoteSection({
    required String title,
    @Default([]) List<String> items,
  }) = _StudyNoteSection;

  factory StudyNoteSection.fromJson(Map<String, dynamic> json) =>
      _$StudyNoteSectionFromJson(json);
}
