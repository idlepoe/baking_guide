import 'package:freezed_annotation/freezed_annotation.dart';

enum ProgressSessionStatus {
  @JsonValue('ready')
  ready,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('abandoned')
  abandoned,
}
