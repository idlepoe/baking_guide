import '../../../data/models/progress_session.dart';
import '../../../data/models/recipe_list_item.dart';

class ProgressSessionListItem {
  const ProgressSessionListItem({
    required this.session,
    required this.listItem,
    required this.currentStepTitle,
    required this.estimatedEndAt,
  });

  final ProgressSession session;
  final RecipeListItem listItem;
  final String currentStepTitle;
  final DateTime estimatedEndAt;
}
