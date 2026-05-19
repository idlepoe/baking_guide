import 'package:freezed_annotation/freezed_annotation.dart';

import 'iso_datetime_converter.dart';

part 'step_progress.freezed.dart';
part 'step_progress.g.dart';

@freezed
abstract class StepProgress with _$StepProgress {
  const factory StepProgress({
    required int stepNo,
    @IsoDateTimeConverter() required DateTime startedAt,
  }) = _StepProgress;

  factory StepProgress.fromJson(Map<String, dynamic> json) =>
      _$StepProgressFromJson(json);
}
