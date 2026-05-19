import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/duration_format.dart';
import '../../../core/utils/mixing_method_format.dart';
import '../../../core/widgets/app_bottom_action_bar.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../data/models/key_point_group.dart';
import '../../../data/models/enums/temperature_unit.dart';
import '../../../data/models/oven_setting.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../data/models/recipe_summary.dart';
import '../controllers/progress_detail_controller.dart';

abstract final class RecipeSummaryBottomSheetColors {
  static const primary = Color(0xFF7E57C2);
  static const cardBackground = Color(0xFFF5F5F5);
  static const deductionBackground = Color(0xFFFFEBEE);
}

class RecipeSummaryBottomSheet extends StatelessWidget {
  const RecipeSummaryBottomSheet({
    super.key,
    required this.recipeName,
    required this.summary,
    required this.listItem,
  });

  final String recipeName;
  final RecipeSummary summary;
  /// [`recipe_list.json`](assets/json/recipe_list.json) 항목 (난이도·시험 시간 등).
  final RecipeListItem listItem;

  static void show(
    BuildContext context,
    ProgressDetailController controller,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      final detail = controller.recipe.value;
      final listItem = controller.recipeListItem.value;
      if (detail == null || listItem == null) {
        Get.snackbar('안내', '레시피 정보를 불러올 수 없습니다.');
        return;
      }

      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (sheetContext) => RecipeSummaryBottomSheet(
          recipeName: detail.name,
          summary: detail.summary,
          listItem: listItem,
        ),
      );
    });
  }

  KeyPointGroup? _keyPointByTitle(String title) {
    for (final group in summary.keyPoints) {
      if (group.title == title) return group;
    }
    return null;
  }

  List<String> _examInfoLines() {
    final lines = <String>[
      '시간: ${formatExamDuration(listItem.totalTimeSec)}',
    ];
    final weighing = _keyPointByTitle('재료 계량');
    if (weighing != null) {
      lines.addAll(weighing.items);
    }
    return lines;
  }

  List<String> _doughLines() {
    final lines = <String>['제법: ${formatMixingMethod(summary.mixingMethod)}'];
    final dough = _keyPointByTitle('반죽');
    if (dough != null) {
      lines.addAll(dough.items);
    }
    return lines;
  }

  List<String> _fermentationLines() {
    final fermentation = _keyPointByTitle('발효');
    return fermentation?.items ?? [];
  }

  List<String> _bakingLines() {
    final lines = <String>[
      _formatOven(summary.oven),
    ];
    final baking = _keyPointByTitle('굽기');
    if (baking != null) {
      lines.addAll(baking.items);
    }
    return lines;
  }

  String _formatOven(OvenSetting oven) {
    final unit = oven.unit == TemperatureUnit.celsius ? '℃' : '℉';
    return '상화: ${oven.top}$unit / 하화: ${oven.bottom}$unit';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.88;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '$recipeName 핵심 정보',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                children: [
                  _SummarySectionCard(
                    icon: Icons.schedule_outlined,
                    title: '시험 정보',
                    lines: _examInfoLines(),
                    trailing: _DifficultyStars(difficulty: listItem.difficulty),
                  ),
                  const SizedBox(height: 12),
                  _SummarySectionCard(
                    icon: Icons.blender_outlined,
                    title: '반죽',
                    lines: _doughLines(),
                  ),
                  const SizedBox(height: 12),
                  _SummarySectionCard(
                    icon: Icons.eco_outlined,
                    title: '발효',
                    lines: _fermentationLines(),
                  ),
                  const SizedBox(height: 12),
                  _SummarySectionCard(
                    icon: Icons.microwave_outlined,
                    title: '굽기',
                    lines: _bakingLines(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            AppBottomActionBar(
              child: AppPrimaryButton(
                label: '닫기',
                height: 56,
                backgroundColor: RecipeSummaryBottomSheetColors.primary,
                foregroundColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummarySectionCard extends StatelessWidget {
  const _SummarySectionCard({
    required this.icon,
    required this.title,
    required this.lines,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final List<String> lines;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (lines.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: RecipeSummaryBottomSheetColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: theme.colorScheme.onSurface),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trailing != null) ...[
                const Spacer(),
                trailing!,
              ],
            ],
          ),
          const SizedBox(height: 10),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                line,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultyStars extends StatelessWidget {
  const _DifficultyStars({required this.difficulty});

  final int difficulty;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '난이도',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: 4),
        ...List.generate(
          5,
          (i) => Icon(
            i < difficulty ? Icons.star : Icons.star_border,
            size: 18,
            color: Colors.amber.shade700,
          ),
        ),
      ],
    );
  }
}
