import 'package:flutter/material.dart';

/// 단일 원형 진행 링 ([CircularProgressIndicator]).
class ProgressRingIndicator extends StatelessWidget {
  const ProgressRingIndicator({
    super.key,
    required this.value,
    required this.color,
    required this.size,
    this.strokeWidth = 4,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
  });

  final double value;
  final Color color;
  final double size;
  final double strokeWidth;
  final EdgeInsets padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final track =
        backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest;

    return SizedBox(
      width: size,
      height: size,
      child: Padding(
        padding: padding,
        child: CircularProgressIndicator(
          value: value.clamp(0.0, 1.0),
          strokeWidth: strokeWidth,
          strokeCap: StrokeCap.round,
          color: color,
          backgroundColor: track,
        ),
      ),
    );
  }
}

/// 바깥(전체)·안쪽(단계) 이중 링 + 중앙 child (FAB 등).
class DualProgressRing extends StatelessWidget {
  const DualProgressRing({
    super.key,
    required this.size,
    required this.outerProgress,
    required this.innerProgress,
    required this.outerColor,
    required this.innerColor,
    required this.child,
    this.outerStrokeWidth = 3.5,
    this.innerStrokeWidth = 3,
    this.innerRingPadding = 6,
    this.backgroundColor,
  });

  final double size;
  final double outerProgress;
  final double innerProgress;
  final Color outerColor;
  final Color innerColor;
  final Widget child;
  final double outerStrokeWidth;
  final double innerStrokeWidth;
  final double innerRingPadding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ProgressRingIndicator(
            value: outerProgress,
            color: outerColor,
            size: size,
            strokeWidth: outerStrokeWidth,
            backgroundColor: backgroundColor,
          ),
          ProgressRingIndicator(
            value: innerProgress,
            color: innerColor,
            size: size,
            strokeWidth: innerStrokeWidth,
            padding: EdgeInsets.all(innerRingPadding),
            backgroundColor: backgroundColor,
          ),
          child,
        ],
      ),
    );
  }
}

/// 카드용 단일 링 + 가운데 퍼센트 텍스트.
class ProgressRingWithLabel extends StatelessWidget {
  const ProgressRingWithLabel({
    super.key,
    required this.progress,
    required this.color,
    this.size = 72,
    this.strokeWidth = 5,
    this.ringPadding = 8,
  });

  final double progress;
  final Color color;
  final double size;
  final double strokeWidth;
  final double ringPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = (progress.clamp(0.0, 1.0) * 100).round();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ProgressRingIndicator(
            value: progress,
            color: color,
            size: size,
            strokeWidth: strokeWidth,
            padding: EdgeInsets.all(ringPadding),
          ),
          Text(
            '$percent%',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
