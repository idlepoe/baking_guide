import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/deduction_severity.dart';

part 'study_common_mistake.freezed.dart';
part 'study_common_mistake.g.dart';

@freezed
abstract class StudyCommonMistake with _$StudyCommonMistake {
  const factory StudyCommonMistake({
    required DeductionSeverity severity,
    required String title,
    required String description,
  }) = _StudyCommonMistake;

  factory StudyCommonMistake.fromJson(Map<String, dynamic> json) =>
      _$StudyCommonMistakeFromJson(json);
}
