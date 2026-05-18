import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/deduction_severity.dart';

part 'deduction_point.freezed.dart';
part 'deduction_point.g.dart';

@freezed
abstract class DeductionPoint with _$DeductionPoint {
  const factory DeductionPoint({
    required DeductionSeverity severity,
    required String text,
  }) = _DeductionPoint;

  factory DeductionPoint.fromJson(Map<String, dynamic> json) =>
      _$DeductionPointFromJson(json);
}
