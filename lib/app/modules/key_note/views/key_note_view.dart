import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/recipe_thumbnail.dart';
import '../../../routes/app_pages.dart';
import '../controllers/key_note_controller.dart';

class KeyNoteView extends GetView<KeyNoteController> {
  const KeyNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.items.isEmpty) {
              return const Center(child: Text('등록된 핵심노트가 없습니다.'));
            }
            return ListView.separated(
              padding: EdgeInsets.fromLTRB(
                16,
                12,
                16,
                16 + MediaQuery.paddingOf(context).bottom,
              ),
              itemCount: controller.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return _KeyNoteCard(item: controller.items[index]);
              },
            );
          }),
        ),
      ],
    );
  }
}

class _KeyNoteCard extends StatelessWidget {
  const _KeyNoteCard({required this.item});

  static const _borderRadius = 8.0;

  final KeyNoteListItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppTheme.listItemCardBackground(scheme),
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          color: scheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed(
            Routes.KEY_NOTE_DETAIL,
            arguments: item.id,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeThumbnail(
                  imageUrl: item.thumbnailUrl,
                  size: 56,
                  borderRadius: 6,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _KeyNoteChips(item: item),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KeyNoteChips extends StatelessWidget {
  const _KeyNoteChips({required this.item});

  final KeyNoteListItem item;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      if (item.hasSections) const _InfoChip(label: '섹션'),
      if (item.hasCommonMistakes) const _InfoChip(label: '실수'),
      if (item.hasFlow) const _InfoChip(label: '플로우'),
      if (item.hasFlashcards) const _InfoChip(label: '카드'),
    ];
    if (chips.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: chips,
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      side: BorderSide(color: scheme.outlineVariant),
      backgroundColor: scheme.surfaceContainerHighest,
      label: Text(label),
    );
  }
}
