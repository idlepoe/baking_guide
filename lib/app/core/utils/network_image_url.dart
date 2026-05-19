/// [Image.network]에서 디코딩 가능한 URL로 보정한다.
///
/// placehold.co는 기본 응답이 SVG라 PNG 경로를 명시해야 한다.
String normalizeNetworkImageUrl(String url) {
  final trimmed = url.trim();
  if (trimmed.isEmpty) return trimmed;

  final uri = Uri.tryParse(trimmed);
  if (uri == null || !uri.host.toLowerCase().contains('placehold.co')) {
    return trimmed;
  }

  final path = uri.path;
  if (_hasRasterExtension(path)) return trimmed;

  final pngPath = path.endsWith('/') ? '${path}image.png' : '$path.png';
  return uri.replace(path: pngPath).toString();
}

bool _hasRasterExtension(String path) {
  final lower = path.toLowerCase();
  return lower.endsWith('.png') ||
      lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.gif') ||
      lower.endsWith('.webp');
}
