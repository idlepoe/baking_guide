import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/datetime_format.dart';
import '../../../core/utils/duration_format.dart';
import '../../../data/models/enums/progress_session_status.dart';
import '../../../core/utils/network_image_url.dart';
import '../../../routes/app_pages.dart';
import '../controllers/progress_list_controller.dart';
import '../models/progress_session_list_item.dart';

class ProgressListView extends GetView<ProgressListController> {
  const ProgressListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('진행'),
        centerTitle: true,
      ),
      body: Obx(() {
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
      }),
    );
  }
}

class _ProgressSessionCard extends GetView<ProgressListController> {
  const _ProgressSessionCard({required this.item});

  final ProgressSessionListItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusLabel = controller.statusLabel(item);
    final stepLabel = item.currentStepTitle.isEmpty
        ? '${item.session.currentStepNo}단계'
        : '${item.session.currentStepNo}단계 · ${item.currentStepTitle}';

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
              _Thumbnail(thumbnailUrl: item.listItem.thumbnailUrl),
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
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '현재 $stepLabel',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
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

class _SessionTimeProgressBar extends StatefulWidget {
  const _SessionTimeProgressBar({
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
    if (!widget.isInProgress) return 1.0;

    final totalMs = widget.estimatedEndAt
        .difference(widget.startedAt)
        .inMilliseconds;
    if (totalMs <= 0) return 1.0;

    final elapsedMs =
        DateTime.now().difference(widget.startedAt).inMilliseconds;
    return (elapsedMs / totalMs).clamp(0.0, 1.0);
  }

  bool get _isOvertime =>
      widget.isInProgress && DateTime.now().isAfter(widget.estimatedEndAt);

  DateTime get _elapsedEnd {
    if (widget.isInProgress) return DateTime.now();
    return widget.completedAt ?? widget.estimatedEndAt;
  }

  Duration get _elapsedDuration =>
      _elapsedEnd.difference(widget.startedAt);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = _progress;
    final percentLabel = '${(progress * 100).round()}%';
    final labelStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  color: _isOvertime
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              percentLabel,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: _isOvertime
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text('시작 ${formatSessionDateTime(widget.startedAt)}', style: labelStyle),
            const Spacer(),
            Text(
              widget.isInProgress
                  ? '진행 ${formatClockDuration(_elapsedDuration)}'
                  : '소요 ${formatClockDuration(_elapsedDuration)}',
              style: labelStyle?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            const Spacer(),
            Text(
              _isOvertime
                  ? '예상 초과 ${formatSessionDateTime(widget.estimatedEndAt)}'
                  : '예상 완료 ${formatSessionDateTime(widget.estimatedEndAt)}',
              style: labelStyle?.copyWith(
                color: _isOvertime ? theme.colorScheme.error : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.thumbnailUrl});

  final String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (thumbnailUrl.isEmpty) {
      return Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.bakery_dining,
          size: 36,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        normalizeNetworkImageUrl(thumbnailUrl),
        width: 72,
        height: 72,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 72,
          height: 72,
          color: theme.colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.bakery_dining,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
