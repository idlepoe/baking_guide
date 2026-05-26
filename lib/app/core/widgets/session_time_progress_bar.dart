import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/datetime_format.dart';

/// 전체 세션 진행 시간 대비(시작~예상종료) 바 + 아이콘 + 현재 단계 퍼센트를 표시한다.
///
/// - `isInProgress=true`이면 1초마다 타이머로 진행률을 업데이트한다.
/// - `completedAt`이 있으면(완료 세션) 오버타임 여부를 판단한다.
class SessionTimeProgressBar extends StatefulWidget {
  const SessionTimeProgressBar({
    super.key,
    required this.startedAt,
    required this.estimatedEndAt,
    required this.isInProgress,
    required this.stepProgress,
    this.completedAt,
  });

  final DateTime startedAt;
  final DateTime estimatedEndAt;
  final DateTime? completedAt;
  final bool isInProgress;
  final double stepProgress;

  @override
  State<SessionTimeProgressBar> createState() => _SessionTimeProgressBarState();
}

abstract final class SessionTimeProgressBarStyles {
  static const iconAsset = 'assets/icons/icon.png';
  static const iconSize = 25.0;
  static const barHeight = 8.0;
  static const timeLabelsTopGap = 4.0;

  static double get trackHeight => iconSize;
  static double get barTop => (iconSize - barHeight) / 2;
  static double get timeLabelsTop => barTop + barHeight + timeLabelsTopGap;
}

class _SessionTimeProgressBarState extends State<SessionTimeProgressBar> {
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
              const iconSize = SessionTimeProgressBarStyles.iconSize;
              const barHeight = SessionTimeProgressBarStyles.barHeight;

              final iconCenterX = markerProgress * barWidth;
              final markerLeft = (iconCenterX - iconSize / 2).clamp(
                0.0,
                barWidth - iconSize,
              );

              return SizedBox(
                height: SessionTimeProgressBarStyles.trackHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: SessionTimeProgressBarStyles.barTop,
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
                      top: SessionTimeProgressBarStyles.timeLabelsTop,
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
                      child: Image.asset(
                        SessionTimeProgressBarStyles.iconAsset,
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
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
          padding: EdgeInsets.only(top: SessionTimeProgressBarStyles.barTop),
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

class _TimeCell extends StatelessWidget {
  const _TimeCell({
    required this.label,
    required this.value,
    required this.labelStyle,
    this.valueColor,
    this.align = TextAlign.start,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final Color? valueColor;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedValueStyle = labelStyle?.copyWith(
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
