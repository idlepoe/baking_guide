import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/mixing_method.dart';
import 'key_point_group.dart';
import 'oven_setting.dart';

part 'recipe_summary.freezed.dart';
part 'recipe_summary.g.dart';

@freezed
abstract class RecipeSummary with _$RecipeSummary {
  const factory RecipeSummary({
    required int examTimeSec,
    required MixingMethod mixingMethod,
    required OvenSetting oven,
    @Default([]) List<KeyPointGroup> keyPoints,
  }) = _RecipeSummary;

  factory RecipeSummary.fromJson(Map<String, dynamic> json) =>
      _$RecipeSummaryFromJson(json);
}
