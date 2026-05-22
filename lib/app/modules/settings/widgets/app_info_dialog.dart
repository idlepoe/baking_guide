import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppInfoDialog {
  static const iconAsset = 'assets/icons/icon.png';
  static const _iconAsset = iconAsset;
  static const _aboutAsset = 'assets/text/app_about.md';

  static Future<void> show(BuildContext context) async {
    final markdown = await rootBundle.loadString(_aboutAsset);
    if (!context.mounted) return;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => _AppInfoDialogBody(markdown: markdown),
    );
  }
}

class _AppInfoDialogBody extends StatelessWidget {
  const _AppInfoDialogBody({required this.markdown});

  final String markdown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.85;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 440, maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Image.asset(
                AppInfoDialog._iconAsset,
                width: 72,
                height: 72,
                fit: BoxFit.contain,
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: _AppAboutMarkdown(markdown: markdown),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    '닫기',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
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

class _AppAboutMarkdown extends StatelessWidget {
  const _AppAboutMarkdown({required this.markdown});

  final String markdown;

  static final _boldPattern = RegExp(r'\*\*(.+?)\*\*');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final widgets = <Widget>[];

    for (final line in markdown.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }
      if (trimmed == '---') {
        widgets.add(const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 1),
        ));
        continue;
      }
      if (trimmed.startsWith('# ')) {
        widgets.add(_heading(
          theme,
          trimmed.substring(2),
          theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ));
        continue;
      }
      if (trimmed.startsWith('## ')) {
        widgets.add(_heading(
          theme,
          trimmed.substring(3),
          theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ));
        continue;
      }
      if (trimmed.startsWith('### ')) {
        widgets.add(_heading(
          theme,
          trimmed.substring(4),
          theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ));
        continue;
      }
      if (trimmed.startsWith('- ')) {
        widgets.add(_bullet(theme, trimmed.substring(2)));
        continue;
      }
      final numbered = RegExp(r'^(\d+)\.\s+(.*)$').firstMatch(trimmed);
      if (numbered != null) {
        widgets.add(_numbered(
          theme,
          numbered.group(1)!,
          numbered.group(2)!,
        ));
        continue;
      }
      widgets.add(_paragraph(theme, trimmed));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _heading(ThemeData theme, String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 6),
      child: _richText(theme, text, style ?? theme.textTheme.bodyLarge),
    );
  }

  Widget _paragraph(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: _richText(
        theme,
        text,
        theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
          height: 1.45,
        ),
      ),
    );
  }

  Widget _bullet(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: _richText(theme, text, theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _numbered(ThemeData theme, String no, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            child: Text(
              '$no.',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: _richText(theme, text, theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _richText(ThemeData theme, String text, TextStyle? baseStyle) {
    final spans = <TextSpan>[];
    var start = 0;

    for (final match in _boldPattern.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ));
      start = match.end;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    if (spans.isEmpty) {
      return Text(text, style: baseStyle);
    }

    return Text.rich(
      TextSpan(style: baseStyle, children: spans),
    );
  }
}
