import 'package:flutter/material.dart';

import '../../../core/utils/network_image_url.dart';

class StepImage extends StatelessWidget {
  const StepImage({
    super.key,
    required this.imageSource,
  });

  final String? imageSource;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: _buildImage(context, theme),
        ),
      ),
    );
  }

  Widget _onImageError(
    ThemeData theme,
    String kind,
    String source,
    Object error,
    StackTrace? stackTrace,
  ) {
    debugPrint(
      '[StepImage] $kind load failed\n'
      '  source: $source\n'
      '  error: $error\n'
      '  stackTrace: $stackTrace',
    );
    return _placeholder(theme);
  }

  Widget _buildImage(BuildContext context, ThemeData theme) {
    if (imageSource == null || imageSource!.isEmpty) {
      debugPrint('[StepImage] imageSource is null or empty');
      return _placeholder(theme);
    }

    final source = imageSource!;
    if (source.startsWith('assets/')) {
      return Image.asset(
        source,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _onImageError(theme, 'asset', source, error, stackTrace),
      );
    }

    final networkUrl = normalizeNetworkImageUrl(source);
    if (networkUrl != source) {
      debugPrint('[StepImage] normalized URL: $source -> $networkUrl');
    }

    return Image.network(
      networkUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          _onImageError(theme, 'network', source, error, stackTrace),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  Widget _placeholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.bakery_dining,
        size: 64,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
