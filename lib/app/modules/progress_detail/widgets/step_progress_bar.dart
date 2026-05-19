import 'package:flutter/material.dart';

import '../../../data/models/recipe_step.dart';
import '../progress_detail_colors.dart';

class StepProgressBar extends StatelessWidget {
  const StepProgressBar({
    super.key,
    required this.steps,
    required this.currentIndex,
    this.onStepTap,
  });

  final List<RecipeStep> steps;
  final int currentIndex;
  final ValueChanged<int>? onStepTap;

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < steps.length; i++) ...[
            if (i > 0)
              SizedBox(
                width: 20,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 3,
                    color: i <= currentIndex
                        ? ProgressDetailColors.accent
                        : ProgressDetailColors.completedStep,
                  ),
                ),
              ),
            _StepNode(
              index: i,
              stepNo: steps[i].stepNo,
              label: steps[i].title,
              isCompleted: i < currentIndex,
              isCurrent: i == currentIndex,
              onTap: onStepTap != null ? () => onStepTap!(i) : null,
            ),
          ],
        ],
      ),
    );
  }
}

class _StepNode extends StatelessWidget {
  const _StepNode({
    required this.index,
    required this.stepNo,
    required this.label,
    required this.isCompleted,
    required this.isCurrent,
    this.onTap,
  });

  final int index;
  final int stepNo;
  final String label;
  final bool isCompleted;
  final bool isCurrent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color circleColor;
    Color textColor;
    Color numberColor;

    if (isCurrent) {
      circleColor = ProgressDetailColors.accent;
      textColor = ProgressDetailColors.accentForeground;
      numberColor = ProgressDetailColors.accentForeground;
    } else if (isCompleted) {
      circleColor = ProgressDetailColors.completedStep;
      textColor = theme.colorScheme.onSurface;
      numberColor = theme.colorScheme.onSurfaceVariant;
    } else {
      circleColor = Colors.white;
      textColor = ProgressDetailColors.inactiveStep;
      numberColor = ProgressDetailColors.inactiveStep;
    }

    final child = SizedBox(
      width: 52,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
              border: isCurrent || isCompleted
                  ? null
                  : Border.all(color: ProgressDetailColors.inactiveStep),
            ),
            alignment: Alignment.center,
            child: Text(
              '$stepNo',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: numberColor,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isCurrent
                  ? ProgressDetailColors.accentForeground
                  : textColor,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return child;
    return GestureDetector(onTap: onTap, child: child);
  }
}
