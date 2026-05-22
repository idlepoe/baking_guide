import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/storage/ingredient_batch_scale_preferences.dart';
import '../../../core/tutorial/tutorial_guide_keys.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../core/widgets/app_bottom_action_bar.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../core/utils/ingredient_format.dart';
import '../../../data/models/recipe_ingredient.dart';
import '../controllers/progress_detail_controller.dart';

abstract final class IngredientsBottomSheetColors {
  static Color summaryBackground(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark
          ? scheme.tertiaryContainer
          : const Color(0xFFFFF8E1);

  static Color summaryIconBackground(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark
          ? scheme.tertiary
          : Colors.amber.shade100;

  static Color summaryIconForeground(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark
          ? scheme.onTertiary
          : Colors.amber.shade800;
}

class IngredientsBottomSheet extends StatefulWidget {
  const IngredientsBottomSheet({
    super.key,
    required this.ingredients,
    required this.controller,
  });

  final List<RecipeIngredient> ingredients;
  final ProgressDetailController controller;

  @override
  State<IngredientsBottomSheet> createState() => _IngredientsBottomSheetState();

  static void show(
    BuildContext context,
    ProgressDetailController controller,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      final ingredients = controller.recipe.value?.ingredients ?? [];
      if (ingredients.isEmpty) {
        AppSnackbar.show(
          context: context,
          title: '안내',
          message: '등록된 재료가 없습니다.',
        );
        return;
      }

      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppTheme.modalBottomSheetBackground(
          Theme.of(context).colorScheme,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (sheetContext) => IngredientsBottomSheet(
          ingredients: ingredients,
          controller: controller,
        ),
      );
    });
  }
}

class _IngredientsBottomSheetState extends State<IngredientsBottomSheet> {
  final _batchScalePreferences = IngredientBatchScalePreferences();

  int _scaleIndex = IngredientBatchScale.exam.index;

  List<RecipeIngredient> get ingredients => widget.ingredients;

  ProgressDetailController get controller => widget.controller;

  String get _recipeId => controller.recipeId;

  IngredientBatchScale get _batchScale =>
      IngredientBatchScale.fromSliderIndex(_scaleIndex);

  @override
  void initState() {
    super.initState();
    _loadBatchScaleIndex();
  }

  Future<void> _loadBatchScaleIndex() async {
    final index = await _batchScalePreferences.loadScaleIndex(_recipeId);
    if (!mounted) return;
    setState(() => _scaleIndex = index);
  }

  void _onBatchScaleIndexChanged(int index) {
    setState(() => _scaleIndex = index);
    _batchScalePreferences.saveScaleIndex(_recipeId, index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
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
                color: scheme.onSurfaceVariant.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
              child: Row(
                children: [
                  Text(
                    '재료 목록',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _SummaryBanner(count: ingredients.length),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: _BatchScaleSlider(
                scaleIndex: _scaleIndex,
                onScaleIndexChanged: _onBatchScaleIndexChanged,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: scheme.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.separated(
                    key: ValueKey(_scaleIndex),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: ingredients.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: scheme.outlineVariant.withValues(alpha: 0.6),
                    ),
                    itemBuilder: (context, index) {
                      final ingredient = ingredients[index];
                      return Obx(() {
                        final checked = controller.checkedIngredientIds
                            .contains(ingredient.name);
                        return _IngredientRow(
                          key: index == 0
                              ? TutorialGuideKeys.firstIngredientCheck
                              : null,
                          ingredient: ingredient,
                          batchScale: _batchScale,
                          checked: checked,
                          onToggle: () => controller.toggleIngredient(
                            ingredient.name,
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
            ),
            AppBottomActionBar(
              child: AppPrimaryButton(
                key: TutorialGuideKeys.ingredientsClose,
                label: '닫기',
                height: 56,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BatchScaleSlider extends StatelessWidget {
  const _BatchScaleSlider({
    required this.scaleIndex,
    required this.onScaleIndexChanged,
  });

  final int scaleIndex;
  final ValueChanged<int> onScaleIndexChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labels = IngredientBatchScale.values.map((s) => s.label).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          key: TutorialGuideKeys.batchSlider,
          value: scaleIndex.toDouble(),
          min: 0,
          max: 2,
          divisions: 2,
          label: labels[scaleIndex],
          onChanged: (value) => onScaleIndexChanged(value.round()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              for (var i = 0; i < labels.length; i++) ...[
                if (i > 0) const Spacer(),
                Text(
                  labels[i],
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight:
                        i == scaleIndex ? FontWeight.bold : FontWeight.normal,
                    color: i == scaleIndex
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryBanner extends StatelessWidget {
  const _SummaryBanner({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: IngredientsBottomSheetColors.summaryBackground(scheme),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor:
                IngredientsBottomSheetColors.summaryIconBackground(scheme),
            child: Icon(
              Icons.restaurant,
              size: 32,
              color: IngredientsBottomSheetColors.summaryIconForeground(scheme),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '총 $count가지 재료',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '계량 후 체크하여 진행하세요!',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientRow extends StatelessWidget {
  const _IngredientRow({
    super.key,
    required this.ingredient,
    required this.batchScale,
    required this.checked,
    required this.onToggle,
  });

  final RecipeIngredient ingredient;
  final IngredientBatchScale batchScale;
  final bool checked;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              checked ? Icons.check_box : Icons.check_box_outline_blank,
              color: checked
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                ingredient.name,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              formatIngredientAmountForScale(
                ingredient,
                scale: batchScale,
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),                                                                                                                                             
      ),
    );
  }
}
