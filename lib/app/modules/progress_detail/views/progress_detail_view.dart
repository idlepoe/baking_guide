import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/tutorial/tutorial_guide_keys.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../data/models/enums/progress_session_status.dart';
import '../../../data/models/recipe_step.dart';
import '../../home/widgets/active_timers_bar.dart';
import '../controllers/progress_detail_controller.dart';
import '../widgets/deduction_points_card.dart';
import '../widgets/ingredients_bottom_sheet.dart';
import '../widgets/recipe_summary_bottom_sheet.dart';
import '../widgets/progress_fab_column.dart';
import '../widgets/step_checklist.dart';
import '../widgets/step_description.dart';
import '../widgets/step_header.dart';
import '../widgets/step_image.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/timer_bottom_sheet.dart';
import '../../../core/widgets/session_time_progress_bar.dart';
import '../../../core/utils/calculator_kind_format.dart';
import '../../../data/models/enums/calculator_kind.dart';
import '../widgets/dough_temp_calculator_bottom_sheet.dart';

const _kStepSectionSpacing = 24.0;

class ProgressDetailView extends StatefulWidget {
  const ProgressDetailView({super.key});

  @override
  State<ProgressDetailView> createState() => _ProgressDetailViewState();
}

class _ProgressDetailViewState extends State<ProgressDetailView> {
  late final ProgressDetailController controller;
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProgressDetailController>();
    controller.scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    _syncBottomReachedState();
    unawaited(controller.syncCurrentStepFromScroll());
  }

  void _syncBottomReachedState() {
    if (!controller.scrollController.hasClients) return;
    final position = controller.scrollController.position;
    final reachedBottom = position.pixels >= (position.maxScrollExtent - 8);
    if (reachedBottom != _isAtBottom) {
      setState(() => _isAtBottom = reachedBottom);
    }
  }

  @override
  void dispose() {
    controller.scrollController.removeListener(_handleScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Obx(() {
          final name = controller.recipe.value?.name ?? '';
          return Text(name);
        }),
        centerTitle: true,
        actions: [
          _AppBarLabeledIconAction(
            icon: Icons.article_outlined,
            label: '핵심 정보',
            onPressed: () => RecipeSummaryBottomSheet.show(context, controller),
          ),
          Obx(
            () => _AppBarLabeledIconAction(
              icon: Icons.egg_alt_outlined,
              label: '재료 목록',
              pendingCount: controller.uncheckedIngredientCount,
              showCompletedBadge: controller.allIngredientsChecked,
              onPressed: () => IngredientsBottomSheet.show(context, controller),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      floatingActionButton: ProgressFabColumn(controller: controller),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ActiveTimersBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.hasError.value ||
                  controller.recipe.value == null) {
                return const Center(child: Text('레시피를 불러올 수 없습니다.'));
              }

              final detail = controller.recipe.value!;
              if (detail.steps.isEmpty) {
                return const Center(child: Text('단계 정보가 없습니다.'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CenteredStepProgressBarScroll(
                    steps: detail.steps,
                    currentIndex: controller.currentStepIndex.value,
                    onStepTap: controller.goToStep,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(() {
                      final session = controller.session.value;
                      final listItem = controller.recipeListItem.value;
                      if (session == null || listItem == null) {
                        return const SizedBox.shrink();
                      }
                      final stepCount = detail.steps.length;
                      if (stepCount <= 0) return const SizedBox.shrink();

                      final isInProgress =
                          session.status == ProgressSessionStatus.inProgress;

                      final stepProgress =
                          session.status == ProgressSessionStatus.completed
                          ? 1.0
                          : (session.currentStepNo / stepCount).clamp(0.0, 1.0);

                      final estimatedEndAt = session.startedAt.add(
                        Duration(seconds: listItem.totalTimeSec),
                      );

                      return SessionTimeProgressBar(
                        startedAt: session.startedAt,
                        estimatedEndAt: estimatedEndAt,
                        completedAt: session.completedAt,
                        isInProgress: isInProgress,
                        stepProgress: stepProgress,
                      );
                    }),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      padding: EdgeInsets.only(
                        bottom: 16 + MediaQuery.paddingOf(context).bottom + 64,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (var i = 0; i < detail.steps.length; i++)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: i < detail.steps.length - 1
                                    ? _kStepSectionSpacing
                                    : 0,
                              ),
                              child: KeyedSubtree(
                                key: controller.stepSectionKeys[i],
                                child: _StepPageContent(
                                  stepIndex: i,
                                  step: detail.steps[i],
                                  controller: controller,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        final active = controller.session.value?.status;
        if (active != ProgressSessionStatus.inProgress) {
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: AppPrimaryButton(
                key: TutorialGuideKeys.practiceStart,
                label: '실기 시작',
                onPressed: () => _handleStartPractice(context),
                height: 48,
                borderRadius: 8,
              ),
            ),
          );
        }

        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: AppPrimaryButton(
              label: _isAtBottom ? '실기 완료' : '실기 종료',
              backgroundColor: _isAtBottom ? null : Colors.red,
              foregroundColor: Colors.white,
              onPressed: _isAtBottom
                  ? controller.completePractice
                  : controller.abandonPractice,
              height: 48,
              borderRadius: 8,
            ),
          ),
        );
      }),
    );
  }

  Future<void> _handleStartPractice(BuildContext context) async {
    await controller.startPractice();
  }
}

class _StepPageContent extends StatelessWidget {
  const _StepPageContent({
    required this.stepIndex,
    required this.step,
    required this.controller,
  });

  final int stepIndex;
  final RecipeStep step;
  final ProgressDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final checkedCount = controller.checkedCountForStep(step);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StepHeader(step: step),
          StepImage(
            key: ValueKey(step.imageUrl),
            imageSource: controller.stepImageUrl(step),
          ),
          StepDescription(descriptions: step.description),
          if (step.timers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: AppPrimaryButton(
                label: '타이머',
                height: 48,
                borderRadius: 8,
                onPressed: () => TimerBottomSheet.show(
                  context,
                  controller,
                  onlyStepNo: step.stepNo,
                ),
              ),
            ),
          if (step.calculators.isNotEmpty &&
              step.calculators.first.type == CalculatorKind.doughTemp)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: AppPrimaryButton(
                key: TutorialGuideKeys.doughTempFab,
                label: calculatorFabLabel(CalculatorKind.doughTemp),
                backgroundColor: const Color(0xFF42A5F5),
                foregroundColor: Colors.white,
                height: 48,
                borderRadius: 8,
                onPressed: () {
                  unawaited(() async {
                    await controller.goToStep(stepIndex);
                    if (!context.mounted) return;
                    DoughTempCalculatorBottomSheet.show(context, controller);
                  }());
                },
              ),
            ),
          if (step.stepNo == 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: AppPrimaryButton(
                label: '재료 목록',
                height: 48,
                borderRadius: 8,
                onPressed: () =>
                    IngredientsBottomSheet.show(context, controller),
              ),
            ),
          StepChecklist(
            items: step.checklist,
            checkedCount: checkedCount,
            isChecked: controller.isChecked,
            onToggle: controller.toggleChecklist,
          ),
          DeductionPointsCard(points: step.deductionPoints),
          if (stepIndex == (controller.recipe.value?.steps.length ?? 1) - 1)
            const SizedBox(height: 80),
        ],
      );
    });
  }
}

class _AppBarLabeledIconAction extends StatelessWidget {
  const _AppBarLabeledIconAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.pendingCount = 0,
    this.showCompletedBadge = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final int pendingCount;
  final bool showCompletedBadge;

  Widget _badgedIcon(IconData icon, Color color) {
    final iconWidget = Icon(icon, size: 22, color: color);
    if (showCompletedBadge) {
      return Badge(
        isLabelVisible: true,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.all(2),
        label: const Icon(Icons.check, size: 10, color: Colors.white),
        child: iconWidget,
      );
    }
    if (pendingCount > 0) {
      final label = pendingCount > 99 ? '99+' : '$pendingCount';
      return Badge(
        isLabelVisible: true,
        backgroundColor: Colors.red,
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: iconWidget,
      );
    }
    return iconWidget;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurface;

    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _badgedIcon(icon, color),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
