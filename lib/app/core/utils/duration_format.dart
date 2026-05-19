String formatExamDuration(int totalTimeSec) {
  final hours = totalTimeSec ~/ 3600;
  final minutes = (totalTimeSec % 3600) ~/ 60;

  if (hours > 0 && minutes > 0) {
    return '$hours시간 $minutes분';
  }
  if (hours > 0) {
    return '$hours시간';
  }
  if (minutes > 0) {
    return '$minutes분';
  }
  return '$totalTimeSec초';
}

String formatStepDuration(int estimatedTimeSec) {
  final minutes = (estimatedTimeSec / 60).ceil();
  if (minutes <= 0) {
    return '$estimatedTimeSec초';
  }
  return '$minutes분';
}
