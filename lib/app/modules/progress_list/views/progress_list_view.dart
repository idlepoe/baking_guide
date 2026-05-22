import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/datetime_format.dart';
import '../../../core/utils/duration_format.dart';
import '../../../data/models/enums/progress_session_status.dart';
import '../../../core/widgets/recipe_thumbnail.dart';
import '../../../routes/app_pages.dart';
import '../controllers/progress_list_controller.dart';
import '../models/progress_session_list_item.dart';

class ProgressListView extends GetView<ProgressListController> {
  const ProgressListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.items.isEmpty) {
          return const Center(child: Text('진행 중인 실기가 없습니다.'));
        }

        return ListView.separated(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            16 + MediaQuery.paddingOf(context).bottom,
          ),
          itemCount: controller.items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _ProgressSessionCard(item: controller.items[index]);
          },
        );
    });
  }
}

class _ProgressSessionCard extends GetView<ProgressListController> {
  const _ProgressSessionCard({required this.item});

  final ProgressSessionListItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusLabel = controller.statusLabel(item);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          await Get.toNamed(
            Routes.PROGRESS_DETAIL,
            arguments: item.session.recipeId,
          );
          await controller.loadSessions();
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RecipeThumbnail(imageUrl: item.listItem.thumbnailUrl),
                  const SizedBox(height: 6),
                  _ThumbnailElapsedDuration(
                    startedAt: item.session.startedAt,
                    estimatedEndAt: item.estimatedEndAt,
                    completedAt: item.session.completedAt,
                    isInProgress: item.session.status ==
                        ProgressSessionStatus.inProgress,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.listItem.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          statusLabel,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _SessionTimeProgressBar(
                      startedAt: item.session.startedAt,
                      estimatedEndAt: item.estimatedEndAt,
                      completedAt: item.session.completedAt,
                      isInProgress: item.session.status ==
                          ProgressSessionStatus.inProgress,
                      stepProgress: item.stepProgress,
                      stageName: item.stageName,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract final class _SessionTimeProgressBarStyles {
  static const iconAsset = 'assets/icons/icon.png';
  static const iconSize = 40.0;
  static const markerWidth = 76.0;
  static const barHeight = 8.0;
  static const labelAreaHeight = 30.0;
  static const timeLabelsTopGap = 4.0;

  static double get trackHeight => iconSize + labelAreaHeight;
  static double get barTop => (iconSize - barHeight) / 2;
  static double get timeLabelsTop => barTop + barHeight + timeLabelsTopGap;
}

class _SessionTimeProgressBar extends StatefulWidget {
  const _SessionTimeProgressBar({
    required this.startedAt,
    required this.estimatedEndAt,
    required this.isInProgress,
    required this.stepProgress,
    required this.stageName,
    this.completedAt,
  });

  final DateTime startedAt;
  final DateTime estimatedEndAt;
  final DateTime? completedAt;
  final bool isInProgress;
  final double stepProgress;
  final String stageName;

  @override
  State<_SessionTimeProgressBar> createState() => _SessionTimeProgressBarState();
}

class _SessionTimeProgressBarState extends State<_SessionTimeProgressBar> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isInProgress) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double get _progress {
    final totalMs = widget.estimatedEndAt
        .difference(widget.startedAt)
        .inMilliseconds;
    if (totalMs <= 0) return 1.0;

    final elapsedEnd = widget.isInProgress
        ? DateTime.now()
        : (widget.completedAt ?? widget.estimatedEndAt);
    final elapsedMs = elapsedEnd.difference(widget.startedAt).inMilliseconds;
    return (elapsedMs / totalMs).clamp(0.0, 1.0);
  }

  bool get _isOvertime {
    if (!widget.isInProgress) {
      final end = widget.completedAt ?? widget.estimatedEndAt;
      return end.isAfter(widget.estimatedEndAt);
    }
    return DateTime.now().isAfter(widget.estimatedEndAt);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = _progress;
    final labelStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    final markerProgress = widget.stepProgress.clamp(0.0, 1.0);
    final stepPercentLabel = '${(markerProgress * 100).round()}%';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              final iconCenterX = markerProgress * barWidth;
              final markerLeft = (iconCenterX -
                      _SessionTimeProgressBarStyles.markerWidth / 2)
                  .clamp(
                0.0,
                barWidth - _SessionTimeProgressBarStyles.markerWidth,
              );
              const iconSize = _SessionTimeProgressBarStyles.iconSize;
              const barHeight = _SessionTimeProgressBarStyles.barHeight;

              return SizedBox(
                height: _SessionTimeProgressBarStyles.trackHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: _SessionTimeProgressBarStyles.barTop,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: barHeight,
                          backgroundColor:
                              theme.colorScheme.surfaceContainerHighest,
                          color: _isOvertime
                              ? theme.colorScheme.error
                              : theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: _SessionTimeProgressBarStyles.timeLabelsTop,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _TimeCell(
                              label: '시작',
                              value: formatSessionDateTime(widget.startedAt),
                              labelStyle: labelStyle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _TimeCell(
                              label: _isOvertime ? '예상 초과' : '예상 완료',
                              value: formatSessionDateTime(
                                widget.estimatedEndAt,
                              ),
                              labelStyle: labelStyle,
                              align: TextAlign.end,
                              valueColor: _isOvertime
                                  ? theme.colorScheme.error
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: markerLeft,
                      top: 0,
                      width: _SessionTimeProgressBarStyles.markerWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            _SessionTimeProgressBarStyles.iconAsset,
                            width: iconSize,
                            height: iconSize,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.stageName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: EdgeInsets.only(
            top: _SessionTimeProgressBarStyles.barTop,
          ),
          child: Text(
            stepPercentLabel,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: _isOvertime
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ThumbnailElapsedDuration extends StatefulWidget {
  const _ThumbnailElapsedDuration({
    required this.startedAt,
    required this.estimatedEndAt,
    required this.isInProgress,
    this.completedAt,
  });

  final DateTime startedAt;
  final DateTime estimatedEndAt;
  final DateTime? completedAt;
  final bool isInProgress;

  @override
  State<_ThumbnailElapsedDuration> createState() =>
      _ThumbnailElapsedDurationState();
}

class _ThumbnailElapsedDurationState extends State<_ThumbnailElapsedDuration> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isInProgress) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Duration get _elapsedDuration {
    final end = widget.isInProgress
        ? DateTime.now()
        : (widget.completedAt ?? widget.estimatedEndAt);
    return end.difference(widget.startedAt);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return SizedBox(
      width: 72,
      child: _TimeCell(
        label: widget.isInProgress ? '진행' : '소요',
        value: formatClockDuration(_elapsedDuration),
        labelStyle: labelStyle,
        align: TextAlign.center,
        valueStyle: labelStyle?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

class _TimeCell extends StatelessWidget {
  const _TimeCell({
    required this.label,
    required this.value,
    required this.labelStyle,
    this.valueStyle,
    this.valueColor,
    this.align = TextAlign.start,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Color? valueColor;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedValueStyle = valueStyle ??
        labelStyle?.copyWith(
          fontWeight: FontWeight.w500,
          color: valueColor ?? theme.colorScheme.onSurface,
        );

    final crossAxisAlignment = switch (align) {
      TextAlign.end => CrossAxisAlignment.end,
      TextAlign.center => CrossAxisAlignment.center,
      _ => CrossAxisAlignment.start,
    };

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: labelStyle,
          textAlign: align,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          value,
          style: resolvedValueStyle,
          textAlign: align,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

