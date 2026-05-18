import 'package:freezed_annotation/freezed_annotation.dart';

part 'evaluation_criterion.freezed.dart';
part 'evaluation_criterion.g.dart';

@freezed
abstract class EvaluationCriterion with _$EvaluationCriterion {
  const factory EvaluationCriterion({
    required String id,
    required String text,
  }) = _EvaluationCriterion;

  factory EvaluationCriterion.fromJson(Map<String, dynamic> json) =>
      _$EvaluationCriterionFromJson(json);
}
