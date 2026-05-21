import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/swipe_step_navigation_service.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../data/models/enums/progress_session_status.dart';
import '../../../data/models/recipe_step.dart';
import '../../home/widgets/active_timers_bar.dart';
import '../controllers/progress_detail_controller.dart';
import '../widgets/deduction_points_card.dart';
import '../widgets/ingredients_bottom_sheet.dart';
import '../widgets/recipe_summary_bottom_sheet.dart';
import '../widgets/progress_bottom_bar.dart';
import '../widgets/progress_fab_column.dart';
import '../widgets/step_checklist.dart';
import '../widgets/step_description.dart';
import '../widgets/step_header.dart';
import '../widgets/step_image.dart';
import '../widgets/step_progress_bar.dart';

class ProgressDetailView extends GetView<ProgressDetailController> {
  const ProgressDetailView({super.key});

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
            onPressed: () =>
                RecipeSummaryBottomSheet.show(context, controller),
          ),
          Obx(
            () => _AppBarLabeledIconAction(
              icon: Icons.egg_alt_outlined,
              label: '재료 목록',
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
              if (controller.hasError.value || controller.recipe.value == null) {
                return const Center(child: Text('레시피를 불러올 수 없습니다.'));
              }

              final detail = controller.recipe.value!;
              final step = controller.currentStep;
              if (step == null) {
                return const Center(child: Text('단계 정보가 없습니다.'));
              }

              final swipeService = Get.find<SwipeStepNavigationService>();
              final swipeEnabled =
                  swipeService.swipeStepNavigationEnabled.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CenteredStepProgressBarScroll(
                    steps: detail.steps,
                    currentIndex: controller.currentStepIndex.value,
                    onStepTap: controller.goToStep,
                  ),
                  StepHeader(step: step),
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      physics: swipeEnabled
                          ? const ClampingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      onPageChanged: controller.onPageChanged,
                      itemCount: detail.steps.length,
                      itemBuilder: (context, index) {
                        final pageStep = detail.steps[index];
                        return _StepPageContent(
                          stepIndex: index,
                          step: pageStep,
                          controller: controller,
                        );
                      },
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
                label: '실기 시작',
                onPressed: controller.startPractice,
                height: 48,
                borderRadius: 8,
              ),
            ),
          );
        }

        return ProgressBottomBar(
          canGoPrevious: controller.canGoPrevious,
          canGoNext: true,
          isLastStep: controller.isLastStep,
          onPrevious: controller.goToPreviousStep,
          onNext: controller.goToNextStep,
        );
      }),
    );
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
      return _ProgressDetailScrollBody(
        stepIndex: stepIndex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StepImage(
              key: ValueKey(step.imageUrl),
              imageSource: controller.stepImageUrl(step),
            ),
            StepDescription(descriptions: step.description),
            StepChecklist(
              items: step.checklist,
              checkedCount: checkedCount,
              isChecked: controller.isChecked,
              onToggle: controller.toggleChecklist,
            ),
            DeductionPointsCard(points: step.deductionPoints),
            const SizedBox(height: 80),
          ],
        ),
      );
    });
  }
}

class _ProgressDetailScrollBody extends StatefulWidget {
  const _ProgressDetailScrollBody({
    required this.stepIndex,
    required this.child,
  });

  final int stepIndex;
  final Widget child;

  @override
  State<_ProgressDetailScrollBody> createState() =>
      _ProgressDetailScrollBodyState();
}

class _ProgressDetailScrollBodyState extends State<_ProgressDetailScrollBody> {
  final _scrollController = ScrollController();
  late final ProgressDetailController _controller;
  Worker? _stepIndexWorker;
  int _lastStepIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<ProgressDetailController>();
    _lastStepIndex = _controller.currentStepIndex.value;
    _stepIndexWorker = ever<int>(_controller.currentStepIndex, (index) {
      if (index != widget.stepIndex) {
        _lastStepIndex = index;
        return;
      }
      if (_lastStepIndex != index) {
        _lastStepIndex = index;
        _scrollToTop();
      }
    });
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.jumpTo(0);
    });
  }

  @override
  void dispose() {
    _stepIndexWorker?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.only(
        bottom: 16 + MediaQuery.paddingOf(context).bottom,
      ),
      child: widget.child,
    );
  }
}

class _AppBarLabeledIconAction extends StatelessWidget {
  const _AppBarLabeledIconAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.showCompletedBadge = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool showCompletedBadge;

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
              Badge(
                isLabelVisible: showCompletedBadge,
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(2),
                label: const Icon(
                  Icons.check,
                  size: 10,
                  color: Colors.white,
                ),
                child: Icon(icon, size: 22, color: color),
              ),
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
