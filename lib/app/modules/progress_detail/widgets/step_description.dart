import 'package:flutter/material.dart';

class StepDescription extends StatelessWidget {
  const StepDescription({super.key, required this.descriptions});

  final List<String> descriptions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (descriptions.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '현재 단계 설명',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...descriptions.map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
