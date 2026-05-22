import '../../../data/models/enums/progress_session_status.dart';
import '../../../data/models/progress_session.dart';
import '../../../data/models/recipe_list_item.dart';

class ProgressSessionListItem {
  const ProgressSessionListItem({
    required this.session,
    required this.listItem,
    required this.currentStepTitle,
    required this.estimatedEndAt,
    required this.totalStepCount,
  });

  final ProgressSession session;
  final RecipeListItem listItem;
  final String currentStepTitle;
  final DateTime estimatedEndAt;
  final int totalStepCount;

  double get stepProgress {
    if (totalStepCount <= 0) return 0;
    if (session.status == ProgressSessionStatus.completed) return 1;
    return (session.currentStepNo / totalStepCount).clamp(0.0, 1.0);
  }

  String get stageName => currentStepTitle.isEmpty
      ? '${session.currentStepNo}단계'
      : currentStepTitle;
}
