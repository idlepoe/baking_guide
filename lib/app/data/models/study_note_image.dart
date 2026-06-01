import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_note_image.freezed.dart';
part 'study_note_image.g.dart';

@freezed
abstract class StudyNoteImage with _$StudyNoteImage {
  const factory StudyNoteImage({
    required String title,
    required String imageUrl,
  }) = _StudyNoteImage;

  factory StudyNoteImage.fromJson(Map<String, dynamic> json) =>
      _$StudyNoteImageFromJson(json);
}
