import 'package:flutter/material.dart';

import '../../../core/tutorial/tutorial_guide_keys.dart';
import '../../../core/widgets/app_primary_button.dart';

enum _FirstStepExitAction { cancel, leave, endAndLeave }

class ProgressBottomBar extends StatelessWidget {
  const ProgressBottomBar({
    super.key,
    required this.canGoPrevious,
    required this.canGoNext,
    required this.onPrevious,
    required this.onExit,
    required this.onExitAndEndPractice,
    required this.onNext,
    this.isLastStep = false,
  });

  final bool canGoPrevious;
  final bool canGoNext;
  final bool isLastStep;
  final VoidCallback onPrevious;
  final VoidCallback onExit;
  final Future<void> Function() onExitAndEndPractice;
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
                onPressed: () => _handlePrevious(context),
                height: 48,
                borderRadius: 8,
                backgroundColor: const Color(0xFF424242),
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppPrimaryButton(
                key: isLastStep ? null : TutorialGuideKeys.nextStep,
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

  Future<void> _handlePrevious(BuildContext context) async {
    if (canGoPrevious) {
      onPrevious();
      return;
    }

    final action = await showDialog<_FirstStepExitAction>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('실기 나가기'),
        content: const Text(
          '첫 번째 단계입니다.\n'
          '이전 화면으로 나가거나, 실기를 종료할 수 있습니다.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(_FirstStepExitAction.cancel),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(_FirstStepExitAction.leave),
            child: const Text('이전 화면으로'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(
              dialogContext,
            ).pop(_FirstStepExitAction.endAndLeave),
            child: const Text('실기 종료하고 나가기'),
          ),
        ],
      ),
    );

    switch (action) {
      case _FirstStepExitAction.leave:
        onExit();
      case _FirstStepExitAction.endAndLeave:
        await onExitAndEndPractice();
      case _FirstStepExitAction.cancel:
      case null:
        break;
    }
  }
}
