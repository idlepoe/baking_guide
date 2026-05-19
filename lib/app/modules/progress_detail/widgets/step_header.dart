import 'package:flutter/material.dart';

import '../../../core/utils/duration_format.dart';
import '../../../data/models/recipe_step.dart';
import '../progress_detail_colors.dart';

class StepHeader extends StatelessWidget {
  const StepHeader({
    super.key,
    required this.step,
  });

  final RecipeStep step;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: ProgressDetailColors.accent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${step.stepNo}단계',
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: ProgressDetailColors.accentForeground,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              step.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '예상 시간 ${formatStepDuration(step.estimatedTimeSec)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
