import 'package:get/get.dart';

import '../../../data/models/enums/progress_session_status.dart';
import '../../../data/repositories/progress_session_repository.dart';
import '../../../data/repositories/recipe_repository.dart';
import '../models/progress_session_list_item.dart';

class ProgressListController extends GetxController {
  ProgressListController({
    ProgressSessionRepository? sessionRepository,
    RecipeRepository? recipeRepository,
  })  : _sessionRepository =
            sessionRepository ?? Get.find<ProgressSessionRepository>(),
        _recipeRepository = recipeRepository ?? RecipeRepository();

  final ProgressSessionRepository _sessionRepository;
  final RecipeRepository _recipeRepository;

  final isLoading = false.obs;
  final items = <ProgressSessionListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSessions();
  }

  Future<void> loadSessions() async {
    isLoading.value = true;

    final sessions = await _sessionRepository.listActiveForUi();
    final enriched = <ProgressSessionListItem>[];

    for (final session in sessions) {
      final listItem = await _recipeRepository.findRecipeListItem(session.recipeId);
      if (listItem == null) continue;

      final detail = await _recipeRepository.loadRecipeDetail(session.recipeId);
      var stepTitle = '';
      if (detail != null) {
        for (final step in detail.steps) {
          if (step.stepNo == session.currentStepNo) {
            stepTitle = step.title;
            break;
          }
        }
      }

      enriched.add(
        ProgressSessionListItem(
          session: session,
          listItem: listItem,
          currentStepTitle: stepTitle,
          estimatedEndAt: session.startedAt.add(
            Duration(seconds: listItem.totalTimeSec),
          ),
        ),
      );
    }

    items.assignAll(enriched);
    isLoading.value = false;
  }

  String statusLabel(ProgressSessionListItem item) {
    return switch (item.session.status) {
      ProgressSessionStatus.inProgress => '진행 중',
      ProgressSessionStatus.completed => '완료',
      _ => '',
    };
  }
}
