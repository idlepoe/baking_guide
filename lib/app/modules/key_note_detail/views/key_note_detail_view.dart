import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/recipe_thumbnail.dart';
import '../../../data/models/enums/deduction_severity.dart';
import '../../../data/models/study_common_mistake.dart';
import '../../../data/models/study_note_image.dart';
import '../../../data/models/study_note_section.dart';
import '../../../data/models/study_note.dart';
import '../controllers/key_note_detail_controller.dart';

class KeyNoteDetailView extends GetView<KeyNoteDetailController> {
  const KeyNoteDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.noteTitle.value.isEmpty
                ? '핵심노트'
                : controller.noteTitle.value,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.errorMessage.value != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.errorMessage.value!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: controller.loadNote,
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }

    final note = controller.note.value;
    if (note == null) {
      return const Center(child: Text('표시할 핵심노트가 없습니다.'));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        _HeaderCard(
          title: controller.noteTitle.value,
          id: note.id,
          thumbnailUrl: controller.thumbnailUrl.value,
        ),
        if (note.flow.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionTitle(title: '공정 플로우'),
          const SizedBox(height: 8),
          ...List.generate(
            note.flow.length,
            (index) => _NumberedItem(
              index: index + 1,
              text: note.flow[index],
            ),
          ),
        ],
        if (note.sections.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionTitle(title: '핵심 정리'),
          const SizedBox(height: 8),
          ...note.sections.map(_StudySectionCard.new),
        ],
        if (note.commonMistakes.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionTitle(title: '자주 하는 실수'),
          const SizedBox(height: 8),
          ...note.commonMistakes.map(_CommonMistakeCard.new),
        ],
        if (note.flashcards.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionTitle(title: '플래시카드'),
          const SizedBox(height: 8),
          ...List.generate(
            note.flashcards.length,
            (index) => _FlashcardTile(
              index: index,
              note: note,
            ),
          ),
        ],
        if (note.images.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionTitle(title: '참고 이미지'),
          const SizedBox(height: 8),
          ...note.images.map((image) => _ImageCard(note: image)),
        ],
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.title,
    required this.id,
    required this.thumbnailUrl,
  });

  final String title;
  final String id;
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final safeTitle = title.isEmpty ? id : title;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          RecipeThumbnail(imageUrl: thumbnailUrl, size: 64, borderRadius: 8),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  safeTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: $id',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}

class _NumberedItem extends StatelessWidget {
  const _NumberedItem({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$index.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}

class _StudySectionCard extends StatelessWidget {
  const _StudySectionCard(this.section);

  final StudyNoteSection section;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ...section.items.map<Widget>(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(item)),
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

class _CommonMistakeCard extends StatelessWidget {
  const _CommonMistakeCard(this.mistake);

  final StudyCommonMistake mistake;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final severity = _severityLabel(mistake.severity);
    final color = _severityColor(context, mistake.severity);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  mistake.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(severity),
                  side: BorderSide(color: color),
                  backgroundColor: color.withAlpha(30),
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(mistake.description),
          ],
        ),
      ),
    );
  }

  String _severityLabel(DeductionSeverity severity) {
    switch (severity) {
      case DeductionSeverity.high:
        return '높음';
      case DeductionSeverity.medium:
        return '중간';
      case DeductionSeverity.low:
        return '낮음';
    }
  }

  Color _severityColor(BuildContext context, DeductionSeverity severity) {
    final scheme = Theme.of(context).colorScheme;
    switch (severity) {
      case DeductionSeverity.high:
        return scheme.error;
      case DeductionSeverity.medium:
        return scheme.tertiary;
      case DeductionSeverity.low:
        return scheme.primary;
    }
  }
}

class _FlashcardTile extends GetView<KeyNoteDetailController> {
  const _FlashcardTile({
    required this.index,
    required this.note,
  });

  final int index;
  final StudyNote note;

  @override
  Widget build(BuildContext context) {
    final card = note.flashcards[index];
    final scheme = Theme.of(context).colorScheme;
    return Obx(() {
      final isOpened = controller.openedFlashcardIndexes.contains(index);
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Material(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => controller.toggleFlashcard(index),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Q. ${card.question}',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  AnimatedCrossFade(
                    firstChild: Text(
                      '탭해서 정답 보기',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    secondChild: Text(
                      'A. ${card.answer}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    crossFadeState: isOpened
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 180),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.note});

  final StudyNoteImage note;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final provider = note.imageUrl.startsWith('assets/')
        ? AssetImage(note.imageUrl) as ImageProvider
        : NetworkImage(note.imageUrl);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: provider,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 160,
                  color: scheme.surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: scheme.onSurfaceVariant,
                    size: 36,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
