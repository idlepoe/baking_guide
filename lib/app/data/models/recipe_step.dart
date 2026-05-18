import 'package:freezed_annotation/freezed_annotation.dart';

import 'calculator_config.dart';
import 'checklist_item.dart';
import 'deduction_point.dart';
import 'step_image.dart';
import 'step_timer.dart';

part 'recipe_step.freezed.dart';
part 'recipe_step.g.dart';

@freezed
abstract class RecipeStep with _$RecipeStep {
  const factory RecipeStep({
    required int stepNo,
    required String title,
    @Default(0) int estimatedTimeSec,
    @Default('') String imageUrl,
    @Default([]) List<String> description,
    @Default([]) List<String> tips,
    @Default([]) List<ChecklistItem> checklist,
    @Default([]) List<DeductionPoint> deductionPoints,
    @Default([]) List<StepTimer> timers,
    @Default([]) List<CalculatorConfig> calculators,
    @Default([]) List<StepImage> images,
  }) = _RecipeStep;

  factory RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);
}
