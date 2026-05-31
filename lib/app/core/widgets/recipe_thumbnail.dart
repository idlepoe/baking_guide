import 'package:flutter/material.dart';

import '../utils/network_image_url.dart';

/// 레시피 목록·상세 썸네일 (assets/ 또는 네트워크 URL).
class RecipeThumbnail extends StatelessWidget {
  const RecipeThumbnail({
    super.key,
    required this.imageUrl,
    this.size = 72,
    this.borderRadius = 8,
  });

  final String imageUrl;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (imageUrl.isEmpty) {
      debugPrint('[RecipeThumbnail] imageUrl is empty');
      return _placeholder(theme);
    }

    final image = imageUrl.startsWith('assets/')
        ? Image.asset(
            imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _onImageError(theme, 'asset', imageUrl, error, stackTrace),
          )
        : Image.network(
            _networkImageUrl(imageUrl),
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _onImageError(
              theme,
              'network',
              imageUrl,
              error,
              stackTrace,
            ),
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: image,
    );
  }

  String _networkImageUrl(String source) {
    final normalized = normalizeNetworkImageUrl(source);
    if (normalized != source) {
      debugPrint('[RecipeThumbnail] normalized URL: $source -> $normalized');
    }
    return normalized;
  }

  Widget _onImageError(
    ThemeData theme,
    String kind,
    String source,
    Object error,
    StackTrace? stackTrace,
  ) {
    debugPrint(
      '[RecipeThumbnail] $kind load failed\n'
      '  source: $source\n'
      '  error: $error\n'
      '  stackTrace: $stackTrace',
    );
    return _placeholder(theme);
  }

  Widget _placeholder(ThemeData theme) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.bakery_dining,
        size: size * 0.5,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
