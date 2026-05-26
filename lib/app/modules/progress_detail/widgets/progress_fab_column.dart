import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/tutorial/tutorial_guide_keys.dart';
import '../controllers/progress_detail_controller.dart';
import 'timer_bottom_sheet.dart';

class ProgressFabColumn extends StatefulWidget {
  const ProgressFabColumn({super.key, required this.controller});

  final ProgressDetailController controller;

  @override
  State<ProgressFabColumn> createState() => _ProgressFabColumnState();
}

class _ProgressFabColumnState extends State<ProgressFabColumn> {
  Timer? _tickTimer;
  late final Worker _sessionWorker;
  late final Worker _stepIndexWorker;

  @override
  void initState() {
    super.initState();
    _sessionWorker = ever(widget.controller.session, (_) {
      _onSessionOrStepChanged();
    });
    _stepIndexWorker = ever(widget.controller.currentStepIndex, (_) {
      _onSessionOrStepChanged();
    });
    _syncTickTimer();
  }

  @override
  void didUpdateWidget(ProgressFabColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncTickTimer();
  }

  @override
  void dispose() {
    _sessionWorker.dispose();
    _stepIndexWorker.dispose();
    _tickTimer?.cancel();
    super.dispose();
  }

  void _onSessionOrStepChanged() {
    if (!mounted) return;
    _syncTickTimer();
    setState(() {});
  }

  void _syncTickTimer() {
    if (widget.controller.hasActiveSession) {
      _tickTimer ??= Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {});
      });
    } else {
      _tickTimer?.cancel();
      _tickTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return _TimerFabWithLabel(
      key: TutorialGuideKeys.timerFab,
      label: '타이머',
      color: scheme.primary,
      icon: Icons.timer_outlined,
      onPressed: () => TimerBottomSheet.show(context, widget.controller),
    );
  }
}

class _TimerFabWithLabel extends StatelessWidget {
  const _TimerFabWithLabel({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  static const _fabSize = 56.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final fabBody = Material(
      color: color,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: _fabSize,
          height: _fabSize,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
      ),
    );

    return SizedBox(
      width: 72,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          fabBody,
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
