import 'package:flutter/material.dart';

import '../../../core/widgets/app_primary_button.dart';

class ProgressBottomBar extends StatelessWidget {
  const ProgressBottomBar({
    super.key,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.onPrevious,
    required this.onNext,
    this.isLastStep = false,
  });

  final bool canGoPrevious;
  final bool canGoNext;
  final bool isLastStep;
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
              child: AppPrimaryButton(
                label: '이전 단계',
                onPressed: canGoPrevious ? onPrevious : null,
                height: 48,
                borderRadius: 8,
                backgroundColor: const Color(0xFF424242),
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppPrimaryButton(
                label: isLastStep ? '완료' : '다음 단계',
                onPressed: onNext,
                height: 48,
                borderRadius: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
