import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../core/utils/duration_format.dart';
import '../../../core/utils/network_image_url.dart';
import '../../../core/widgets/app_bottom_action_bar.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../core/widgets/difficulty_stars.dart';
import '../../../data/models/key_point_group.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../data/models/recipe_summary.dart';
import '../controllers/progress_detail_controller.dart';

abstract final class RecipeSummaryBottomSheetColors {
  static Color sectionBackground(
    ColorScheme scheme, {
    required bool isWarning,
  }) {
    if (isWarning) {
      return scheme.brightness == Brightness.dark
          ? scheme.errorContainer
          : const Color(0xFFFFEBEE);
    }
    return scheme.brightness == Brightness.dark
        ? scheme.surfaceContainerHigh
        : const Color(0xFFF5F5F5);
  }

  static Color? warningForeground(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark
      ? scheme.onErrorContainer
      : Colors.red.shade900;

  static Color warningIcon(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark ? scheme.error : Colors.red.shade700;

  static Color iconPlaceholderBackground(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark
      ? scheme.surfaceContainerHighest
      : Colors.white;
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
  final RecipeListItem listItem;

  static void show(BuildContext context, ProgressDetailController controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      final detail = controller.recipe.value;
      final listItem = controller.recipeListItem.value;
      if (detail == null || listItem == null) {
        AppSnackbar.show(
          context: context,
          title: '안내',
          message: '레시피 정보를 불러올 수 없습니다.',
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
        builder: (sheetContext) => RecipeSummaryBottomSheet(
          recipeName: detail.name,
          summary: detail.summary,
          listItem: listItem,
        ),
      );
    });
  }

  List<String> _linesForKeyPoint(KeyPointGroup group) {
    if (group.title == '시험 정보') {
      return ['시험 시간: ${formatExamDuration(listItem.totalTimeSec)}'];
    }
    return group.items;
  }

  bool _isWarningKeyPoint(KeyPointGroup group) => group.title == '주요 감점 포인트';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    // 내용 높이에 맞추고, 화면을 넘을 때만 상한까지 스크롤한다.
    final maxSheetHeight = MediaQuery.sizeOf(context).height * 0.92;

    final cards = <Widget>[];
    for (var i = 0; i < summary.keyPoints.length; i++) {
      final group = summary.keyPoints[i];
      final lines = _linesForKeyPoint(group);
      if (lines.isEmpty && group.title != '시험 정보') continue;

      if (i > 0) cards.add(const SizedBox(height: 12));
      cards.add(
        _SummarySectionCard(
          imageUrl: group.imageUrl,
          fallbackIcon: _fallbackIconForTitle(group.title),
          title: group.title == '시험 정보' ? '' : group.title,
          lines: lines,
          trailing: group.title == '시험 정보'
              ? DifficultyStars(
                  difficulty: listItem.difficulty,
                  size: 18,
                )
              : null,
          isWarning: _isWarningKeyPoint(group),
        ),
      );
    }

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxSheetHeight),
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
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [...cards, const SizedBox(height: 16)],
                ),
              ),
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

  IconData _fallbackIconForTitle(String title) {
    return switch (title) {
      '시험 정보' => Icons.schedule_outlined,
      '반죽' => Icons.blender_outlined,
      '발효' => Icons.eco_outlined,
      '굽기' => Icons.microwave_outlined,
      '주요 감점 포인트' => Icons.warning_amber_rounded,
      _ => Icons.label_outline_rounded,
    };
  }
}

class _SummarySectionCard extends StatelessWidget {
  const _SummarySectionCard({
    required this.imageUrl,
    required this.fallbackIcon,
    required this.title,
    required this.lines,
    this.trailing,
    this.isWarning = false,
  });

  final String imageUrl;
  final IconData fallbackIcon;
  final String title;
  final List<String> lines;
  final Widget? trailing;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    if (lines.isEmpty && title.isEmpty && trailing == null) {
      return const SizedBox.shrink();
    }

    final bgColor = RecipeSummaryBottomSheetColors.sectionBackground(
      scheme,
      isWarning: isWarning,
    );
    final warningTextColor = isWarning
        ? RecipeSummaryBottomSheetColors.warningForeground(scheme)
        : null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: scheme.brightness == Brightness.dark
            ? Border.all(
                color: isWarning
                    ? scheme.error.withValues(alpha: 0.4)
                    : scheme.outlineVariant.withValues(alpha: 0.45),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _KeyPointImage(
            imageUrl: imageUrl,
            fallbackIcon: fallbackIcon,
            isWarning: isWarning,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: warningTextColor,
                      ),
                    ),
                  ),
                ...lines.map(
                  (line) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      line,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                        color: warningTextColor,
                      ),
                    ),
                  ),
                ),
                if (trailing != null) ...[const SizedBox(height: 4), trailing!],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyPointImage extends StatelessWidget {
  const _KeyPointImage({
    required this.imageUrl,
    required this.fallbackIcon,
    required this.isWarning,
  });

  final String imageUrl;
  final IconData fallbackIcon;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final iconColor = isWarning
        ? RecipeSummaryBottomSheetColors.warningIcon(scheme)
        : scheme.onSurfaceVariant;

    if (imageUrl.isEmpty) {
      return _iconBox(context, fallbackIcon, iconColor);
    }

    if (imageUrl.startsWith('assets/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imageUrl,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _iconBox(context, fallbackIcon, iconColor),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        normalizeNetworkImageUrl(imageUrl),
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _iconBox(context, fallbackIcon, iconColor),
      ),
    );
  }

  Widget _iconBox(BuildContext context, IconData icon, Color color) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: RecipeSummaryBottomSheetColors.iconPlaceholderBackground(scheme),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 28, color: color),
    );
  }
}

