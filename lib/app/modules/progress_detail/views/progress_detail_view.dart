import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: Obx(() {
          final name = controller.recipe.value?.name ?? '';
          return Text(name.isEmpty ? '실기 진행' : '$name 실기 진행');
        }),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.article_outlined),
            tooltip: '핵심 정보',
            onPressed: () =>
                RecipeSummaryBottomSheet.show(context, controller),
          ),
          IconButton(
            icon: const Icon(Icons.egg_alt_outlined),
            tooltip: '재료 목록',
            onPressed: () => IngredientsBottomSheet.show(context, controller),
          ),
        ],
      ),
      floatingActionButton: const ProgressFabColumn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Obx(() {
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StepProgressBar(
                steps: detail.steps,
                currentIndex: controller.currentStepIndex.value,
                onStepTap: controller.goToStep,
              ),
            ),
            StepHeader(step: step),
            Expanded(
              child: _ProgressDetailScrollBody(
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
                      checkedCount: controller.checkedCountForCurrentStep,
                      isChecked: controller.isChecked,
                      onToggle: controller.toggleChecklist,
                    ),
                    DeductionPointsCard(points: step.deductionPoints),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(
        () => ProgressBottomBar(
          canGoPrevious: controller.canGoPrevious,
          canGoNext: controller.canGoNext,
          onPrevious: controller.goToPreviousStep,
          onNext: controller.goToNextStep,
        ),
      ),
    );
  }
}

class _ProgressDetailScrollBody extends StatefulWidget {
  const _ProgressDetailScrollBody({required this.child});

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
      if (index != _lastStepIndex) {
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
