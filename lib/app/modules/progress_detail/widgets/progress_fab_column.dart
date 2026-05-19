import 'package:flutter/material.dart';

import '../controllers/progress_detail_controller.dart';
import 'timer_bottom_sheet.dart';

class ProgressFabColumn extends StatelessWidget {
  const ProgressFabColumn({super.key, required this.controller});

  final ProgressDetailController controller;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FabWithLabel(
          label: '타이머',
          color: scheme.primary,
          icon: Icons.timer_outlined,
          onPressed: () => TimerBottomSheet.show(context, controller),
        ),
        const SizedBox(height: 12),
        _FabWithLabel(
          label: '계산기',
          color: const Color(0xFF42A5F5),
          icon: Icons.calculate_outlined,
          onPressed: () {
            // TODO: 계산기 FAB 동작 (steps[].calculators 연동)
          },
        ),
      ],
    );
  }
}

class _FabWithLabel extends StatelessWidget {
  const _FabWithLabel({
    required this.label,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.red.shade300,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Material(
            color: color,
            shape: const CircleBorder(),
            elevation: 2,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(icon, color: Colors.white, size: 28),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
