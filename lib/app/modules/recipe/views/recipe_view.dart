import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/tutorial/tutorial_guide_keys.dart';
import '../../../core/utils/duration_format.dart';
import '../../../core/utils/exam_type_format.dart';
import '../../../core/widgets/difficulty_stars.dart';
import '../../../core/widgets/recipe_thumbnail.dart';
import '../../../data/models/enums/exam_type.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../routes/app_pages.dart';
import '../controllers/recipe_controller.dart';

/// 레시피 탭 본문. AppBar·「보유 재료」액션은 [HomeView] + [RecipeAppBarActions].
class RecipeView extends GetView<RecipeController> {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _ExamTypeFilterBar(),
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.recipes.isEmpty) {
              final message = controller.examTypeFilter.value == ExamType.baking
                  ? '등록된 제빵 레시피가 없습니다.'
                  : '등록된 제과 레시피가 없습니다.';
              return Center(child: Text(message));
            }
            return ListView.separated(
              padding: EdgeInsets.fromLTRB(
                16,
                12,
                16,
                16 + MediaQuery.paddingOf(context).bottom,
              ),
              itemCount: controller.recipes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return _RecipeCard(recipe: controller.recipes[index]);
              },
            );
          }),
        ),
      ],
    );
  }
}

class _ExamTypeFilterBar extends GetView<RecipeController> {
  const _ExamTypeFilterBar();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.examTypeFilter.value;
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SegmentedButton<ExamType>(
          segments: [
            ButtonSegment(
              value: ExamType.baking,
              label: Text(formatExamType(ExamType.baking)),
            ),
            ButtonSegment(
              value: ExamType.confectionery,
              label: Text(formatExamType(ExamType.confectionery)),
            ),
          ],
          selected: {selected},
          onSelectionChanged: (selection) {
            if (selection.isEmpty) return;
            controller.setExamTypeFilter(selection.first);
          },
        ),
      );
    });
  }
}

class _RecipeCard extends GetView<RecipeController> {
  const _RecipeCard({required this.recipe});

  static const _borderRadius = 8.0;

  final RecipeListItem recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Obx(() {
      final hasAllIngredients = controller.hasAllOwnedIngredientsForRecipe(
        recipe.id,
      );
      final cardColor = AppTheme.listItemCardBackground(scheme);

      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            color: hasAllIngredients ? scheme.tertiary : scheme.outlineVariant,
            width: hasAllIngredients ? 1.5 : 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: InkWell(
                      key: recipe.id == TutorialGuideKeys.demoRecipeId
                          ? TutorialGuideKeys.recipeCard
                          : null,
                      onTap: () => Get.toNamed(
                        Routes.PROGRESS_DETAIL,
                        arguments: recipe.id,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RecipeThumbnail(
                              imageUrl: recipe.thumbnailUrl,
                              size: 56,
                              borderRadius: 6,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: hasAllIngredients ? 14 : 0,
                                    ),
                                    child: Text(
                                      recipe.name,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 14,
                                        color: scheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        formatExamDuration(recipe.totalTimeSec),
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: scheme.onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  DifficultyStars(
                                    difficulty: recipe.difficulty,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => _RecipeBookmarkTrailing(
                      key: recipe.id == TutorialGuideKeys.demoRecipeId
                          ? TutorialGuideKeys.recipeBookmark
                          : null,
                      backgroundColor: cardColor,
                      borderRadius: _borderRadius,
                      isBookmarked: controller.isBookmarked(recipe.id),
                      onPressed: () => controller.toggleBookmark(recipe.id),
                    ),
                  ),
                ],
              ),
            ),
            if (hasAllIngredients)
              Positioned(
                top: 0,
                left: 0,
                child: Material(
                  color: scheme.tertiaryContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    bottomRight: const Radius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    child: Text(
                      '재료 있음',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: scheme.onTertiaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

class _RecipeBookmarkTrailing extends StatelessWidget {
  const _RecipeBookmarkTrailing({
    super.key,
    required this.backgroundColor,
    required this.borderRadius,
    required this.isBookmarked,
    required this.onPressed,
  });

  final Color backgroundColor;
  final double borderRadius;
  final bool isBookmarked;
  final VoidCallback onPressed;

  static const _trailingWidth = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trailingRadius = BorderRadius.only(
      topRight: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );
    return SizedBox(
      width: _trailingWidth,
      child: ClipRRect(
        borderRadius: trailingRadius,
        child: Material(
          color: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: trailingRadius),
          child: InkWell(
            onTap: onPressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: theme.colorScheme.outlineVariant,
                ),
                Expanded(
                  child: Center(
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
