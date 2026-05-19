import 'package:flutter/material.dart';

import '../progress_detail_colors.dart';

class ProgressBottomBar extends StatelessWidget {
  const ProgressBottomBar({
    super.key,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.onPrevious,
    required this.onNext,
  });

  final bool canGoPrevious;
  final bool canGoNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: canGoPrevious ? onPrevious : null,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF424242),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFE0E0E0),
                  disabledForegroundColor: const Color(0xFF9E9E9E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('이전 단계'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: canGoNext ? onNext : null,
                style: FilledButton.styleFrom(
                  backgroundColor: ProgressDetailColors.accent,
                  foregroundColor: ProgressDetailColors.accentForeground,
                  disabledBackgroundColor: const Color(0xFFE0E0E0),
                  disabledForegroundColor: const Color(0xFF9E9E9E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('다음 단계'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
