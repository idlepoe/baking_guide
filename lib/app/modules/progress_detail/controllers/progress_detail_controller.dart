import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/enums/progress_session_status.dart';
import '../../../data/models/progress_session.dart';
import '../../../data/models/step_progress.dart';
import '../../../data/models/recipe_detail.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../data/models/recipe_step.dart';
import '../../../data/repositories/progress_session_repository.dart';
import '../../../data/repositories/recipe_repository.dart';
import '../../../routes/app_pages.dart';

class ProgressDetailController extends GetxController {
  ProgressDetailController({
    required this.recipeId,
    RecipeRepository? repository,
    ProgressSessionRepository? sessionRepository,
  })  : _repository = repository ?? RecipeRepository(),
        _sessionRepository =
            sessionRepository ?? Get.find<ProgressSessionRepository>();

  final String recipeId;
  final RecipeRepository _repository;
  final ProgressSessionRepository _sessionRepository;
  final _uuid = const Uuid();

  final isLoading = true.obs;
  final hasError = false.obs;
  final recipe = Rxn<RecipeDetail>();
  final recipeListItem = Rxn<RecipeListItem>();
  final session = Rxn<ProgressSession>();
  final currentStepIndex = 0.obs;
  final checkedItemIds = <String>{}.obs;
  final checkedIngredientIds = <String>{}.obs;

  late final PageController pageController;

  bool get hasActiveSession =>
      session.value?.status == ProgressSessionStatus.inProgress;

  DateTime? stepStartedAt(int stepNo) {
    final current = session.value;
    if (current == null) return null;
    for (final entry in current.steps) {
      if (entry.stepNo == stepNo) return entry.startedAt;
    }
    return null;
  }

  Duration get sessionElapsed {
    final current = session.value;
    if (current == null) return Duration.zero;
    return DateTime.now().difference(current.startedAt);
  }

  Duration get currentStepElapsed {
    final step = currentStep;
    if (step == null) return Duration.zero;
    final started = stepStartedAt(step.stepNo);
    if (started == null) return Duration.zero;
    return DateTime.now().difference(started);
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    if (recipeId.isEmpty) {
      _handleLoadFailure('레시피 정보가 없습니다.');
      return;
    }
    _loadRecipe();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  RecipeStep? get currentStep {
    final detail = recipe.value;
    if (detail == null || detail.steps.isEmpty) return null;
    final index = currentStepIndex.value;
    if (index < 0 || index >= detail.steps.length) return null;
    return detail.steps[index];
  }

  bool get canGoPrevious => currentStepIndex.value > 0;

  bool get canGoNext {
    final detail = recipe.value;
    if (detail == null || detail.steps.isEmpty) return false;
    return currentStepIndex.value < detail.steps.length - 1;
  }

  bool get isLastStep => hasActiveSession && !canGoNext;

  int get checkedCountForCurrentStep {
    final step = currentStep;
    if (step == null) return 0;
    return checkedCountForStep(step);
  }

  int checkedCountForStep(RecipeStep step) {
    return step.checklist
        .where((item) => checkedItemIds.contains(item.id))
        .length;
  }

  Future<void> _loadRecipe() async {
    isLoading.value = true;
    hasError.value = false;

    final detail = await _repository.loadRecipeDetail(recipeId);
    if (detail == null || detail.steps.isEmpty) {
      _handleLoadFailure('레시피를 불러올 수 없습니다.');
      return;
    }

    recipeListItem.value = await _repository.findRecipeListItem(recipeId);
    recipe.value = detail;

    final existing = await _sessionRepository.findInProgressByRecipeId(recipeId);
    if (existing != null) {
      session.value = existing;
      final index = _indexForStepNo(existing.currentStepNo);
      if (index != null && index >= 0) {
        currentStepIndex.value = index;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (pageController.hasClients) {
            pageController.jumpToPage(index);
          }
        });
      }
    }

    isLoading.value = false;
  }

  int? _indexForStepNo(int stepNo) {
    final detail = recipe.value;
    if (detail == null) return null;
    return detail.steps.indexWhere((step) => step.stepNo == stepNo);
  }

  void _handleLoadFailure(String message) {
    isLoading.value = false;
    hasError.value = true;
    Get.snackbar('오류', message);
    Future.microtask(() => Get.offAllNamed(Routes.HOME));
  }

  Future<void> startPractice() async {
    final detail = recipe.value;
    if (detail == null || detail.steps.isEmpty) return;

    final now = DateTime.now();
    final firstStepNo = detail.steps.first.stepNo;
    final newSession = ProgressSession(
      sessionId: _uuid.v4(),
      recipeId: recipeId,
      status: ProgressSessionStatus.inProgress,
      startedAt: now,
      updatedAt: now,
      currentStepNo: firstStepNo,
      completedSteps: const [],
      steps: [StepProgress(stepNo: firstStepNo, startedAt: now)],
    );

    await _sessionRepository.upsert(newSession);
    session.value = newSession;
    await goToStep(0);
  }

  Future<void> completePractice() async {
    final current = session.value;
    final step = currentStep;
    if (current == null || step == null) return;

    final completed = List<int>.from(current.completedSteps);
    if (!completed.contains(step.stepNo)) {
      completed.add(step.stepNo);
    }

    final now = DateTime.now();
    final updated = current.copyWith(
      status: ProgressSessionStatus.completed,
      completedAt: now,
      updatedAt: now,
      currentStepNo: step.stepNo,
      completedSteps: completed,
    );

    await _sessionRepository.upsert(updated);
    session.value = null;
    Get.back();
  }

  List<StepProgress> _stepsWithStartedAt(
    List<StepProgress> steps,
    int stepNo,
    DateTime startedAt,
  ) {
    final index = steps.indexWhere((entry) => entry.stepNo == stepNo);
    final entry = StepProgress(stepNo: stepNo, startedAt: startedAt);
    if (index < 0) {
      return [...steps, entry];
    }
    final updated = List<StepProgress>.from(steps);
    updated[index] = entry;
    return updated;
  }

  Future<void> _persistSession({
    List<int>? completedSteps,
    bool recordStepStarted = true,
  }) async {
    final current = session.value;
    final step = currentStep;
    if (current == null || step == null) return;

    final now = DateTime.now();
    final updated = current.copyWith(
      currentStepNo: step.stepNo,
      completedSteps: completedSteps ?? current.completedSteps,
      steps: recordStepStarted
          ? _stepsWithStartedAt(current.steps, step.stepNo, now)
          : current.steps,
      updatedAt: now,
    );

    await _sessionRepository.upsert(updated);
    session.value = updated;
  }

  void onPageChanged(int index) {
    if (currentStepIndex.value == index) return;
    currentStepIndex.value = index;
    if (hasActiveSession) {
      _persistSession();
    }
  }

  Future<void> goToPreviousStep() async {
    if (!canGoPrevious) return;
    await goToStep(currentStepIndex.value - 1);
  }

  Future<void> goToNextStep() async {
    if (!hasActiveSession) return;

    if (!canGoNext) {
      await completePractice();
      return;
    }

    final detail = recipe.value!;
    final fromStep = detail.steps[currentStepIndex.value];
    final completed = List<int>.from(session.value!.completedSteps);
    if (!completed.contains(fromStep.stepNo)) {
      completed.add(fromStep.stepNo);
    }

    await goToStep(
      currentStepIndex.value + 1,
      completedSteps: completed,
    );
  }

  Future<void> goToStep(int index, {List<int>? completedSteps}) async {
    final detail = recipe.value;
    if (detail == null) return;
    if (index < 0 || index >= detail.steps.length) return;

    final stepChanged = currentStepIndex.value != index;
    if (stepChanged) {
      currentStepIndex.value = index;
    }
    if (pageController.hasClients) {
      final page = pageController.page?.round();
      if (page != index) {
        pageController.jumpToPage(index);
      }
    }
    if (hasActiveSession && (stepChanged || completedSteps != null)) {
      await _persistSession(
        completedSteps: completedSteps,
        recordStepStarted: stepChanged,
      );
    }
  }

  bool isChecked(String id) => checkedItemIds.contains(id);

  void toggleChecklist(String id) {
    if (checkedItemIds.contains(id)) {
      checkedItemIds.remove(id);
    } else {
      checkedItemIds.add(id);
    }
    checkedItemIds.refresh();
  }

  void toggleIngredient(String name) {
    if (checkedIngredientIds.contains(name)) {
      checkedIngredientIds.remove(name);
    } else {
      checkedIngredientIds.add(name);
    }
    checkedIngredientIds.refresh();
  }

  String? stepImageUrl(RecipeStep step) {
    final url = step.imageUrl.trim();
    if (url.isEmpty) return null;
    return url;
  }
}
