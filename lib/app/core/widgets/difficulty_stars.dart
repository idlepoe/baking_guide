import 'package:flutter/material.dart';

/// 난이도 1~5 별 표시. 채움(앰버)·빈(옅은 회색)으로 구분.
class DifficultyStars extends StatelessWidget {
  const DifficultyStars({
    super.key,
    required this.difficulty,
    this.size = 16,
    this.showLabel = true,
  });

  final int difficulty;
  final double size;
  final bool showLabel;

  static Color filledColor(Brightness brightness) =>
      brightness == Brightness.dark
          ? const Color(0xFFFFCA28)
          : const Color(0xFFE65100);

  static Color emptyColor(ColorScheme scheme) =>
      scheme.onSurfaceVariant.withValues(alpha: 0.4);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final filled = filledColor(theme.brightness);
    final empty = emptyColor(scheme);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Text(
            '난이도',
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 4),
        ],
        ...List.generate(
          5,
          (i) => Icon(
            i < difficulty ? Icons.star : Icons.star_border,
            size: size,
            color: i < difficulty ? filled : empty,
          ),
        ),
      ],
    );
  }
}
