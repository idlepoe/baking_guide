import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/duration_format.dart';
import '../../../core/utils/network_image_url.dart';
import '../../../core/widgets/app_bottom_action_bar.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../data/models/key_point_group.dart';
import '../../../data/models/recipe_list_item.dart';
import '../../../data/models/recipe_summary.dart';
import '../controllers/progress_detail_controller.dart';

abstract final class RecipeSummaryBottomSheetColors {
  static const primary = Color(0xFF7E57C2);
  static const cardBackground = Color(0xFFF5F5F5);
  static const warningBackground = Color(0xFFFFEBEE);
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

  List<String> _linesForKeyPoint(KeyPointGroup group) {
    if (group.title == '시험 정보') {
      return ['시험 시간: ${formatExamDuration(listItem.totalTimeSec)}'];
    }
    return group.items;
  }

  bool _isWarningKeyPoint(KeyPointGroup group) =>
      group.title == '주요 감점 포인트';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              ? _DifficultyStars(difficulty: listItem.difficulty)
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
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...cards,
                    const SizedBox(height: 16),
                  ],
                ),
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

    if (lines.isEmpty && title.isEmpty && trailing == null) {
      return const SizedBox.shrink();
    }

    final bgColor = isWarning
        ? RecipeSummaryBottomSheetColors.warningBackground
        : RecipeSummaryBottomSheetColors.cardBackground;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
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
                        color: isWarning ? Colors.red.shade900 : null,
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
                        color: isWarning ? Colors.red.shade900 : null,
                      ),
                    ),
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(height: 4),
                  trailing!,
                ],
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
    final iconColor = isWarning ? Colors.red.shade700 : null;

    if (imageUrl.isEmpty) {
      return _iconBox(fallbackIcon, iconColor);
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
              _iconBox(fallbackIcon, iconColor),
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
            _iconBox(fallbackIcon, iconColor),
      ),
    );
  }

  Widget _iconBox(IconData icon, Color? color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 28, color: color),
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
