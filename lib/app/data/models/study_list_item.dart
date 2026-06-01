import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_list_item.freezed.dart';
part 'study_list_item.g.dart';

/// `study_list.json` 항목 — 핵심노트가 있는 레시피 id.
@freezed
abstract class StudyListItem with _$StudyListItem {
  const factory StudyListItem({
    required String id,
  }) = _StudyListItem;

  factory StudyListItem.fromJson(Map<String, dynamic> json) =>
      _$StudyListItemFromJson(json);
}
