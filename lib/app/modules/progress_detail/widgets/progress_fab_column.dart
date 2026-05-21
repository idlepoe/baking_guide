import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_snackbar.dart';
import '../../../core/utils/calculator_kind_format.dart';
import '../../../data/models/enums/calculator_kind.dart';
import '../controllers/progress_detail_controller.dart';
import 'dough_temp_calculator_bottom_sheet.dart';
import 'progress_ring_indicator.dart';
import 'timer_bottom_sheet.dart';

class ProgressFabColumn extends StatefulWidget {
  const ProgressFabColumn({super.key, required this.controller});

  final ProgressDetailController controller;

  @override
  State<ProgressFabColumn> createState() => _ProgressFabColumnState();
}

class _ProgressFabColumnState extends State<ProgressFabColumn> {
  Timer? _tickTimer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _syncTickTimer();
  }

  @override
  void didUpdateWidget(ProgressFabColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncTickTimer();
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }

  void _syncTickTimer() {
    if (widget.controller.hasActiveSession) {
      _tickTimer ??= Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() => _now = DateTime.now());
      });
    } else {
      _tickTimer?.cancel();
      _tickTimer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final showProgress = widget.controller.hasActiveSession;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TimerFabWithLabel(
          label: '타이머',
          color: scheme.primary,
          innerColor: scheme.tertiary,
          icon: Icons.timer_outlined,
          showProgress: showProgress,
          sessionProgress:
              widget.controller.sessionProgressAt(_now),
          stepProgress: widget.controller.stepProgressAt(_now),
          onPressed: () =>
              TimerBottomSheet.show(context, widget.controller),
        ),
        Obx(() {
          final calculator = widget.controller.currentCalculator;
          if (calculator == null) {
            return const SizedBox.shrink();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              _FabWithLabel(
                label: calculatorFabLabel(calculator.type),
                color: const Color(0xFF42A5F5),
                icon: calculatorFabIcon(calculator.type),
                onPressed: () => _onCalculatorFabPressed(
                  context,
                  calculator.type,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  void _onCalculatorFabPressed(BuildContext context, CalculatorKind type) {
    switch (type) {
      case CalculatorKind.doughTemp:
        DoughTempCalculatorBottomSheet.show(context, widget.controller);
      case CalculatorKind.divisionWeight:
      case CalculatorKind.bakerPercentage:
        AppSnackbar.show(
          context: context,
          title: '안내',
          message: '해당 계산기는 준비 중입니다.',
        );
    }
  }
}

class _TimerFabWithLabel extends StatelessWidget {
  const _TimerFabWithLabel({
    required this.label,
    required this.color,
    required this.innerColor,
    required this.icon,
    required this.showProgress,
    required this.sessionProgress,
    required this.stepProgress,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final Color innerColor;
  final IconData icon;
  final bool showProgress;
  final double sessionProgress;
  final double stepProgress;
  final VoidCallback onPressed;

  static const _fabSize = 56.0;
  static const _ringContainerSize = 72.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showProgress)
          DualProgressRing(
            size: _ringContainerSize,
            outerProgress: sessionProgress,
            innerProgress: stepProgress,
            outerColor: color,
            innerColor: innerColor,
            backgroundColor: scheme.surfaceContainerHighest,
            child: fabBody,
          )
        else
          fabBody,
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
        Material(
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
