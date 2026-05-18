import 'package:freezed_annotation/freezed_annotation.dart';

import 'calculator_config.dart';
import 'checklist_item.dart';
import 'deduction_point.dart';
import 'step_image.dart';
import 'step_timer.dart';

part 'step.freezed.dart';
part 'step.g.dart';

@freezed
abstract class Step with _$Step {
  const factory Step({
    required int stepNo,
    required String title,
    required int estimatedTimeSec,
    @Default([]) List<String> description,
    @Default([]) List<StepImage> images,
    @Default([]) List<ChecklistItem> checklist,
    @Default([]) List<DeductionPoint> deductionPoints,
    @Default([]) List<StepTimer> timers,
    @Default([]) List<CalculatorConfig> calculators,
  }) = _Step;

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
}
