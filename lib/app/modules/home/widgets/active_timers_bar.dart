import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/active_timer_entry.dart';
import '../../../core/services/timer_schedule_service.dart';
import '../../../core/utils/active_timers_nav_log.dart';
import '../../../core/utils/duration_format.dart';
import '../../../routes/app_pages.dart';
import '../../progress_detail/controllers/progress_detail_controller.dart';

/// Home 상단: 진행 중인 모든 타이머를 progress bar + 남은 시간으로 표시.
class ActiveTimersBar extends StatefulWidget {
  const ActiveTimersBar({super.key});

  @override
  State<ActiveTimersBar> createState() => _ActiveTimersBarState();
}

class _ActiveTimersBarState extends State<ActiveTimersBar> {
  Timer? _tickTimer;
  DateTime _now = DateTime.now();

  TimerScheduleService get _scheduleService => Get.find<TimerScheduleService>();

  @override
  void initState() {
    super.initState();
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
    unawaited(_scheduleService.refreshActiveEntries());
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final entries = _scheduleService.activeEntries;
      if (entries.isEmpty) {
        return const SizedBox.shrink();
      }

      final theme = Theme.of(context);
      final scheme = theme.colorScheme;

      return Material(
        color: scheme.primaryContainer.withValues(alpha: 0.35),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            itemCount: entries.length,
            separatorBuilder: (_, _) => const SizedBox.shrink(),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return _ActiveTimerTile(
                entry: entry,
                now: _now,
                onTap: entry.recipeId.isEmpty
                    ? null
                    : () => _openProgressDetail(
                          entry.recipeId,
                          timerId: entry.timer.timerId,
                        ),
                onDelete: () => _confirmAndStopTimer(entry),
              );
            },
          ),
        ),
      );
    });
  }

  Future<void> _openProgressDetail(
    String recipeId, {
    required String timerId,
  }) async {
    final currentRoute = Get.currentRoute;
    final previousRoute = Get.previousRoute;
    final controllerRegistered =
        Get.isRegistered<ProgressDetailController>();
    final onProgressDetail = currentRoute == Routes.PROGRESS_DETAIL;

    ActiveTimersNavLog.d(
      'tap timerId=$timerId recipeId=$recipeId '
      'currentRoute=$currentRoute previousRoute=$previousRoute '
      'targetRoute=${Routes.PROGRESS_DETAIL} onProgressDetail=$onProgressDetail '
      'controllerRegistered=$controllerRegistered',
    );

    try {
      if (onProgressDetail) {
        ActiveTimersNavLog.d('branch=back+toNamed (leave then re-enter)');
        Get.back();
        ActiveTimersNavLog.d(
          'back done currentRoute=${Get.currentRoute} '
          'controllerRegistered=${Get.isRegistered<ProgressDetailController>()}',
        );
        final result = await Get.toNamed(
          Routes.PROGRESS_DETAIL,
          arguments: recipeId,
        );
        ActiveTimersNavLog.d(
          'toNamed after back result=$result newRoute=${Get.currentRoute} '
          'controllerRegistered=${Get.isRegistered<ProgressDetailController>()}',
        );
      } else {
        ActiveTimersNavLog.d('branch=toNamed (push progress detail)');
        final result = await Get.toNamed(
          Routes.PROGRESS_DETAIL,
          arguments: recipeId,
        );
        ActiveTimersNavLog.d(
          'toNamed done result=$result newRoute=${Get.currentRoute}',
        );
      }
    } catch (error, stackTrace) {
      ActiveTimersNavLog.e(
        'navigation failed recipeId=$recipeId',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }

    if (!mounted) {
      ActiveTimersNavLog.d('widget unmounted after navigation, skip refresh');
      return;
    }
    await _scheduleService.refreshActiveEntries();
    ActiveTimersNavLog.d('refreshActiveEntries done');
  }

  Future<void> _confirmAndStopTimer(ActiveTimerEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('타이머 종료'),
        content: Text(
          '${entry.recipeName} · ${entry.label} 타이머를 종료할까요?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('종료'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    await _scheduleService.cancelTimer(entry.timer.timerId);
  }
}

class _ActiveTimerTile extends StatelessWidget {
  const _ActiveTimerTile({
    required this.entry,
    required this.now,
    this.onTap,
    required this.onDelete,
  });

  final ActiveTimerEntry entry;
  final DateTime now;
  final VoidCallback? onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final progress = entry.progressAt(now);
    final remaining = entry.remainingAt(now);
    final title = '${entry.recipeName} · ${entry.label}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 18,
                              color: scheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              formatClockDuration(remaining),
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: scheme.primary,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 6,
                            backgroundColor:
                                scheme.surfaceContainerHighest,
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: '타이머 종료',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                color: scheme.error,
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(height: 1, color: theme.dividerColor),
        ],
      ),
    );
  }
}
