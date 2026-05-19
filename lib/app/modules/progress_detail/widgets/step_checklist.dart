import 'package:flutter/material.dart';

import '../../../data/models/checklist_item.dart';

class StepChecklist extends StatelessWidget {
  const StepChecklist({
    super.key,
    required this.items,
    required this.checkedCount,
    required this.isChecked,
    required this.onToggle,
  });

  final List<ChecklistItem> items;
  final int checkedCount;
  final bool Function(String id) isChecked;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '단계 체크',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '$checkedCount / ${items.length}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...items.map(
              (item) => _ChecklistTile(
                item: item,
                checked: isChecked(item.id),
                onToggle: () => onToggle(item.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChecklistTile extends StatelessWidget {
  const _ChecklistTile({
    required this.item,
    required this.checked,
    required this.onToggle,
  });

  final ChecklistItem item;
  final bool checked;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: checked ? const Color(0xFF4CAF50) : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                Icon(
                  checked ? Icons.check_box : Icons.check_box_outline_blank,
                  color: checked ? Colors.white : theme.colorScheme.onSurface,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: checked
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
