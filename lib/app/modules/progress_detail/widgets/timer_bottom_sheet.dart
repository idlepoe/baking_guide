import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/exact_alarm_permission.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../core/services/timer_schedule_service.dart';
import '../../../core/utils/duration_format.dart';
import '../../../data/models/enums/timer_kind.dart';
import '../../../data/models/practice_timer.dart';
import '../../../data/models/step_timer.dart';
import '../controllers/progress_detail_controller.dart';

abstract final class TimerBottomSheetColors {
  static const activeRowBackground = Color(0xFFFFF8E1);
}

abstract final class _CustomTimerConfig {
  static const label = '커스텀 타이머';
  static const minMinutes = 5;
  static const maxMinutes = 60;
  static const stepMinutes = 5;
  static const defaultMinutes = 30;
  static const divisions =
      (maxMinutes - minMinutes) ~/ stepMinutes; // 5~60, 5분 간격

  static int clampMinutes(int minutes) =>
      minutes.clamp(minMinutes, maxMinutes);
}

class TimerBottomSheet extends StatefulWidget {
  const TimerBottomSheet({super.key, required this.controller});

  final ProgressDetailController controller;

  static Future<void> show(
    BuildContext context,
    ProgressDetailController controller,
  ) async {
    if (!controller.hasActiveSession) {
      AppSnackbar.show(
        context: context,
        title: '안내',
        message: '실기를 시작한 후 타이머를 사용할 수 있습니다.',
      );
      return;
    }

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
  int _customMinutes = _CustomTimerConfig.defaultMinutes;

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
    final timers =
        await _scheduleService.activeTimersForSession(session.sessionId);
    if (mounted) {
      for (final timer in timers) {
        final ctx = _scheduleService.displayContextFor(timer.timerId);
        if (ctx?.label == _CustomTimerConfig.label &&
            timer.endsAt.isAfter(DateTime.now())) {
          _customMinutes =
              _CustomTimerConfig.clampMinutes(timer.durationSec ~/ 60);
          break;
        }
      }
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

  PracticeTimer? _activeCustomTimer() {
    for (final timer in _activeTimers) {
      final ctx = _scheduleService.displayContextFor(timer.timerId);
      if (ctx?.label == _CustomTimerConfig.label) return timer;
    }
    return null;
  }

  StepTimer _customPreset() => StepTimer(
        type: TimerKind.step,
        label: _CustomTimerConfig.label,
        durationSec: _customMinutes * 60,
      );

  Future<void> _onStartCustom() => _onStartPreset(_customPreset());

  Future<void> _onStopCustom() async {
    final active = _activeCustomTimer();
    if (active != null) await _onStopPreset(active);
  }

  Future<void> _onStartPreset(StepTimer preset) async {
    final session = widget.controller.session.value;
    final step = widget.controller.currentStep;
    final recipeName = widget.controller.recipe.value?.name ?? '';
    if (session == null || step == null) return;

    final ok = await _scheduleService.startTimer(
      session: session,
      stepNo: step.stepNo,
      preset: preset,
      recipeName: recipeName,
    );
    if (!ok) {
      AppSnackbar.show(
        title: '타이머',
        message: '알림 예약에 실패했습니다. 알림·알람 권한을 확인해 주세요.',
        actionLabel: Platform.isAndroid ? '설정 열기' : null,
        onAction: Platform.isAndroid ? ExactAlarmPermission.openSettings : null,
      );
    } else if (Platform.isAndroid) {
      final exactGranted = await ExactAlarmPermission.isGranted();
      if (!exactGranted && mounted) {
        AppSnackbar.show(
          title: '알람 권한',
          message: '설정에서 「알람 및 리마인더」를 허용하면 타이머가 정확한 시각에 울립니다.',
          duration: const Duration(seconds: 6),
          actionLabel: '설정 열기',
          onAction: ExactAlarmPermission.openSettings,
        );
      }
    }
    await _refreshActiveTimers();
    if (mounted) setState(() {});
  }

  Future<void> _onStopPreset(PracticeTimer active) async {
    await _scheduleService.cancelTimer(active.timerId);
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
    final customActive = _activeCustomTimer();

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
                        '공정 타이머',
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
                          onStop: active != null &&
                                  active.endsAt.isAfter(_now)
                              ? () => _onStopPreset(active)
                              : null,
                        );
                      }),
                    ],
                    const SizedBox(height: 20),
                    _CustomTimerSection(
                      minutes: _customMinutes,
                      active: customActive,
                      now: _now,
                      onMinutesChanged: (minutes) {
                        setState(
                          () => _customMinutes =
                              _CustomTimerConfig.clampMinutes(minutes),
                        );
                      },
                      onStart: _onStartCustom,
                      onStop: customActive != null &&
                              customActive.endsAt.isAfter(_now)
                          ? _onStopCustom
                          : null,
                    ),
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

class _CustomTimerSection extends StatelessWidget {
  const _CustomTimerSection({
    required this.minutes,
    required this.active,
    required this.now,
    required this.onMinutesChanged,
    required this.onStart,
    this.onStop,
  });

  final int minutes;
  final PracticeTimer? active;
  final DateTime now;
  final ValueChanged<int> onMinutesChanged;
  final VoidCallback onStart;
  final VoidCallback? onStop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRunning = active != null && active!.endsAt.isAfter(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _CustomTimerConfig.label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        if (!isRunning) ...[
          Row(
            children: [
              Text(
                '${_CustomTimerConfig.minMinutes}분',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Expanded(
                child: Slider(
                  value: minutes.toDouble(),
                  min: _CustomTimerConfig.minMinutes.toDouble(),
                  max: _CustomTimerConfig.maxMinutes.toDouble(),
                  divisions: _CustomTimerConfig.divisions,
                  label: '$minutes분',
                  onChanged: (value) => onMinutesChanged(
                    _CustomTimerConfig.clampMinutes(value.round()),
                  ),
                ),
              ),
              Text(
                '${_CustomTimerConfig.maxMinutes}분',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              '$minutes분',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        _StepTimerRow(
          preset: StepTimer(
            type: TimerKind.step,
            label: _CustomTimerConfig.label,
            durationSec: minutes * 60,
          ),
          active: active,
          now: now,
          onPlay: onStart,
          onStop: onStop,
        ),
      ],
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
    this.onStop,
  });

  final StepTimer preset;
  final PracticeTimer? active;
  final DateTime now;
  final VoidCallback onPlay;
  final VoidCallback? onStop;

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
        color: isRunning
            ? TimerBottomSheetColors.activeRowBackground
            : scheme.surface,
        border: Border.all(
          color: isRunning
              ? scheme.primary
              : theme.dividerColor.withValues(alpha: 0.3),
          width: isRunning ? 2 : 1,
        ),
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
                const SizedBox(height: 4),
                Text(
                  isRunning && remaining != null
                      ? formatClockDuration(remaining)
                      : formatClockSeconds(preset.durationSec),
                  style: isRunning
                      ? theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.primary,
                          letterSpacing: 1,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        )
                      : theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                ),
              ],
            ),
          ),
          if (isRunning && onStop != null) ...[
            Material(
              color: scheme.surfaceContainerHighest,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onStop,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.stop_rounded,
                    color: scheme.error,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
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
