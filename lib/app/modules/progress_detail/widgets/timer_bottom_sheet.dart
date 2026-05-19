import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/notification_service.dart';
import '../../../core/services/timer_schedule_service.dart';
import '../../../core/utils/duration_format.dart';
import '../../../data/models/practice_timer.dart';
import '../../../data/models/step_timer.dart';
import '../controllers/progress_detail_controller.dart';

class TimerBottomSheet extends StatefulWidget {
  const TimerBottomSheet({super.key, required this.controller});

  final ProgressDetailController controller;

  static Future<void> show(
    BuildContext context,
    ProgressDetailController controller,
  ) async {
    if (!controller.hasActiveSession) {
      Get.snackbar('안내', '실기를 시작한 후 타이머를 사용할 수 있습니다.');
      return;
    }

    await NotificationService.instance.requestPermissions();
    await Get.find<TimerScheduleService>().syncExpiredTimers();

    if (!context.mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => TimerBottomSheet(controller: controller),
    );
  }

  @override
  State<TimerBottomSheet> createState() => _TimerBottomSheetState();
}

class _TimerBottomSheetState extends State<TimerBottomSheet> {
  Timer? _tickTimer;
  DateTime _now = DateTime.now();
  List<PracticeTimer> _activeTimers = [];

  TimerScheduleService get _scheduleService => Get.find<TimerScheduleService>();

  @override
  void initState() {
    super.initState();
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) => _onTick());
    _refreshActiveTimers();
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }

  Future<void> _onTick() async {
    if (!mounted) return;
    setState(() => _now = DateTime.now());
    await _refreshActiveTimers();
  }

  Future<void> _refreshActiveTimers() async {
    final session = widget.controller.session.value;
    if (session == null) return;
    final timers = await _scheduleService.activeTimersForSession(session.sessionId);
    if (mounted) {
      setState(() => _activeTimers = timers);
    }
  }

  PracticeTimer? _activeForPreset(StepTimer preset) {
    for (final timer in _activeTimers) {
      if (timer.type == preset.type && timer.durationSec == preset.durationSec) {
        return timer;
      }
    }
    return null;
  }

  Future<void> _onStartPreset(StepTimer preset) async {
    final session = widget.controller.session.value;
    final step = widget.controller.currentStep;
    final recipeName = widget.controller.recipe.value?.name ?? '';
    if (session == null || step == null) return;

    await _scheduleService.startTimer(
      session: session,
      stepNo: step.stepNo,
      preset: preset,
      recipeName: recipeName,
    );
    await _refreshActiveTimers();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final session = widget.controller.session.value;
    final listItem = widget.controller.recipeListItem.value;
    final step = widget.controller.currentStep;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.88;

    if (session == null || listItem == null || step == null) {
      return const SizedBox.shrink();
    }

    final totalSec = listItem.totalTimeSec;
    final sessionElapsed = _now.difference(session.startedAt);
    final sessionProgress =
        totalSec > 0 ? (sessionElapsed.inSeconds / totalSec).clamp(0.0, 1.0) : 0.0;

    final stepStarted = widget.controller.stepStartedAt(step.stepNo);
    final stepElapsed = stepStarted != null
        ? _now.difference(stepStarted)
        : Duration.zero;
    final stepTotalSec = step.estimatedTimeSec;
    final stepProgress = stepTotalSec > 0
        ? (stepElapsed.inSeconds / stepTotalSec).clamp(0.0, 1.0)
        : 0.0;

    final stepTimers = step.timers;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Text(
                      '타이머',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProgressCard(
                      title: '전체 시험 시간',
                      elapsed: sessionElapsed,
                      totalLabel: '총 ${formatClockSeconds(totalSec)}',
                      progress: sessionProgress,
                      progressColor: scheme.primary,
                    ),
                    const SizedBox(height: 12),
                    _ProgressCard(
                      title: '현재 단계 시간 (${step.title})',
                      elapsed: stepElapsed,
                      totalLabel: '예상 ${formatClockSeconds(stepTotalSec)}',
                      progress: stepProgress,
                      progressColor: scheme.tertiary,
                    ),
                    if (stepTimers.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        '발효 타이머',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...stepTimers.map((preset) {
                        final active = _activeForPreset(preset);
                        return _StepTimerRow(
                          preset: preset,
                          active: active,
                          now: _now,
                          onPlay: () => _onStartPreset(preset),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.title,
    required this.elapsed,
    required this.totalLabel,
    required this.progress,
    required this.progressColor,
  });

  final String title;
  final Duration elapsed;
  final String totalLabel;
  final double progress;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = (progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  formatClockDuration(elapsed),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  totalLabel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  strokeWidth: 6,
                  color: progressColor,
                  backgroundColor:
                      theme.colorScheme.surfaceContainerHighest,
                ),
                Text(
                  '$percent%',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: progressColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTimerRow extends StatelessWidget {
  const _StepTimerRow({
    required this.preset,
    required this.active,
    required this.now,
    required this.onPlay,
  });

  final StepTimer preset;
  final PracticeTimer? active;
  final DateTime now;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isRunning = active != null && active!.endsAt.isAfter(now);
    final remaining = isRunning ? active!.endsAt.difference(now) : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  preset.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isRunning && remaining != null
                      ? formatClockDuration(remaining)
                      : formatClockSeconds(preset.durationSec),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isRunning
                        ? scheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: scheme.primary,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPlay,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  isRunning ? Icons.replay : Icons.play_arrow,
                  color: scheme.onPrimary,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
