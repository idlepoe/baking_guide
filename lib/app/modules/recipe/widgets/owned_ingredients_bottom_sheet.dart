import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/ingredient_category_format.dart';
import '../../../core/widgets/app_bottom_action_bar.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../data/models/catalog_ingredient.dart';
import '../../../data/models/enums/ingredient_category.dart';
import '../controllers/recipe_controller.dart';

class OwnedIngredientsBottomSheet extends StatelessWidget {
  const OwnedIngredientsBottomSheet({super.key, required this.controller});

  final RecipeController controller;

  static void show(BuildContext context, RecipeController controller) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.modalBottomSheetBackground(
        Theme.of(context).colorScheme,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => OwnedIngredientsBottomSheet(controller: controller),
    );
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
                    '보유 재료',
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '보유한 재료를 체크하세요. (전체 레시피 기준)',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      final allChecked = controller.allOwnedIngredientsChecked;
                      return TextButton(
                        onPressed: controller.toggleAllOwnedIngredients,
                        child: Text(allChecked ? '모두 해제' : '모두 체크하기'),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Obx(() {
                if (controller.isCatalogLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final sections = controller.catalogByCategory;
                if (sections.isEmpty) {
                  return const Center(child: Text('등록된 재료가 없습니다.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return _CategorySection(
                      category: section.category,
                      items: section.items,
                      controller: controller,
                    );
                  },
                );
              }),
            ),
            AppBottomActionBar(
              child: AppPrimaryButton(
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

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.category,
    required this.items,
    required this.controller,
  });

  final IngredientCategory category;
  final List<CatalogIngredient> items;
  final RecipeController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  formatIngredientCategory(category),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
              ),
              Obx(() {
                final allChecked =
                    controller.areAllOwnedIngredientsCheckedForItems(items);
                return TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () =>
                      controller.toggleCategoryOwnedIngredients(items),
                  child: Text(allChecked ? '전체 해제' : '전체 선택'),
                );
              }),
            ],
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: scheme.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    color: scheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                Obx(
                  () => _OwnedIngredientRow(
                    name: items[i].name,
                    checked: controller.isOwnedIngredientChecked(items[i].name),
                    onToggle: () => controller.toggleOwnedIngredient(items[i].name),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _OwnedIngredientRow extends StatelessWidget {
  const _OwnedIngredientRow({
    required this.name,
    required this.checked,
    required this.onToggle,
  });

  final String name;
  final bool checked;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
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
              child: Text(name, style: theme.textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
