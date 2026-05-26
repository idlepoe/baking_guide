import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/duration_format.dart';
import '../../../data/models/enums/progress_session_status.dart';
import '../../../core/widgets/recipe_thumbnail.dart';
import '../../../core/widgets/session_time_progress_bar.dart';
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
                    isInProgress:
                        item.session.status == ProgressSessionStatus.inProgress,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.listItem.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              _CurrentStageChip(label: item.stageName),
                            ],
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
                    SessionTimeProgressBar(
                      startedAt: item.session.startedAt,
                      estimatedEndAt: item.estimatedEndAt,
                      completedAt: item.session.completedAt,
                      isInProgress:
                          item.session.status ==
                          ProgressSessionStatus.inProgress,
                      stepProgress: item.stepProgress,
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

class _CurrentStageChip extends StatelessWidget {
  const _CurrentStageChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Chip(
      label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      labelStyle: theme.textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onPrimaryContainer,
      ),
      backgroundColor: theme.colorScheme.primaryContainer,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
    this.align = TextAlign.start,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedValueStyle =
        valueStyle ??
        labelStyle?.copyWith(
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface,
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
