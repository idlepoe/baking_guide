import 'package:flutter/material.dart';

/// 전체 너비 기본 액션 버튼.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.height = 56,
    this.borderRadius = 12,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.primary;
    final fg = foregroundColor ?? theme.colorScheme.onPrimary;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: theme.colorScheme.surfaceContainerHighest,
          disabledForegroundColor: theme.colorScheme.onSurfaceVariant,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: onPressed == null ? null : fg,
          ),
        ),
      ),
    );
  }
}
