import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/step_image_type.dart';

part 'step_image.freezed.dart';
part 'step_image.g.dart';

@freezed
abstract class StepImage with _$StepImage {
  const factory StepImage({
    required StepImageType type,
    required String title,
    @Default('') String imageUrl,
    @Default('') String description,
  }) = _StepImage;

  factory StepImage.fromJson(Map<String, dynamic> json) =>
      _$StepImageFromJson(json);
}
