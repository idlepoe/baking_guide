import 'package:flutter/material.dart';

/// AppBar 우측 아이콘 + 짧은 라벨 액션 (progress_detail·레시피 탭 공용).
class AppBarLabeledIconAction extends StatelessWidget {
  const AppBarLabeledIconAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.pendingCount = 0,
    this.showCompletedBadge = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final int pendingCount;
  final bool showCompletedBadge;

  Widget _badgedIcon(IconData icon, Color color) {
    final iconWidget = Icon(icon, size: 22, color: color);
    if (showCompletedBadge) {
      return Badge(
        isLabelVisible: true,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.all(2),
        label: const Icon(Icons.check, size: 10, color: Colors.white),
        child: iconWidget,
      );
    }
    if (pendingCount > 0) {
      final badgeLabel = pendingCount > 99 ? '99+' : '$pendingCount';
      return Badge(
        isLabelVisible: true,
        backgroundColor: Colors.red,
        label: Text(
          badgeLabel,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: iconWidget,
      );
    }
    return iconWidget;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurface;

    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _badgedIcon(icon, color),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
