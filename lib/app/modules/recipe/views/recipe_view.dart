import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/tutorial/tutorial_guide_keys.dart';
import '../../../core/utils/duration_format.dart';
import '../../../core/widgets/recipe_thumbnail.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../routes/app_pages.dart';
import '../controllers/recipe_controller.dart';

class RecipeView extends GetView<RecipeController> {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.recipes.isEmpty) {
        return const Center(child: Text('등록된 레시피가 없습니다.'));
      }
      return ListView.separated(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.paddingOf(context).bottom,
        ),
        itemCount: controller.recipes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _RecipeCard(recipe: controller.recipes[index]);
        },
      );
    });
  }
}

class _RecipeCard extends GetView<RecipeController> {
  const _RecipeCard({required this.recipe});

  final RecipeListItem recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InkWell(
                key: recipe.id == TutorialGuideKeys.demoRecipeId
                    ? TutorialGuideKeys.recipeCard
                    : null,
                onTap: () =>
                    Get.toNamed(Routes.PROGRESS_DETAIL, arguments: recipe.id),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecipeThumbnail(imageUrl: recipe.thumbnailUrl),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  formatExamDuration(recipe.totalTimeSec),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '난이도',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                ...List.generate(
                                  5,
                                  (i) => Icon(
                                    i < recipe.difficulty
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 18,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
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
                isBookmarked: controller.isBookmarked(recipe.id),
                onPressed: () => controller.toggleBookmark(recipe.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecipeBookmarkTrailing extends StatelessWidget {
  const _RecipeBookmarkTrailing({
    super.key,
    required this.isBookmarked,
    required this.onPressed,
  });

  final bool isBookmarked;
  final VoidCallback onPressed;

  static const _trailingWidth = 52.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: _trailingWidth,
      child: Material(
        color: theme.colorScheme.surface,
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
    );
  }
}
