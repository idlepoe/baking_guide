import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../utils/network_image_url.dart';

/// [photo_view] 기반 전체 화면 이미지 확대 다이얼로그.
class ZoomableImageDialog extends StatelessWidget {
  const ZoomableImageDialog({
    super.key,
    required this.imageUrl,
    this.title,
  });

  final String imageUrl;
  final String? title;

  static Future<void> show(
    BuildContext context, {
    required String imageUrl,
    String? title,
  }) {
    if (imageUrl.isEmpty) return Future.value();
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (context) => ZoomableImageDialog(
        imageUrl: imageUrl,
        title: title,
      ),
    );
  }

  static ImageProvider<Object> imageProviderFor(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return AssetImage(imageUrl);
    }
    return NetworkImage(normalizeNetworkImageUrl(imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    final provider = imageProviderFor(imageUrl);

    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PhotoView(
            imageProvider: provider,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 4,
            initialScale: PhotoViewComputedScale.contained,
            loadingBuilder: (context, event) {
              if (event == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white70),
                );
              }
              final total = event.expectedTotalBytes;
              final loaded = event.cumulativeBytesLoaded;
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white70,
                  value: total != null ? loaded / total : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              debugPrint(
                '[ZoomableImageDialog] load failed: $imageUrl\n$error',
              );
              return Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 48,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                    tooltip: '닫기',
                  ),
                  if (title != null && title!.isNotEmpty)
                    Expanded(
                      child: Text(
                        title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
