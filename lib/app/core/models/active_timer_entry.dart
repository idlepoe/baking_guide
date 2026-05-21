import '../../data/models/practice_timer.dart';

/// Home 등 UI에 표시할 진행 중 타이머 스냅샷.
class ActiveTimerEntry {
  const ActiveTimerEntry({
    required this.timer,
    required this.recipeName,
    required this.label,
    required this.recipeId,
  });

  final PracticeTimer timer;
  final String recipeName;
  final String label;
  final String recipeId;

  double progressAt(DateTime now) {
    final total = timer.durationSec;
    if (total <= 0) return 0;
    final remainingSec = timer.endsAt.difference(now).inSeconds;
    final elapsed = total - remainingSec;
    return (elapsed / total).clamp(0.0, 1.0);
  }

  Duration remainingAt(DateTime now) {
    final diff = timer.endsAt.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }
}
