import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_seed_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_theme_controller.dart';

class ThemeColorBottomSheet extends StatelessWidget {
  const ThemeColorBottomSheet({super.key});

  static void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (sheetContext) => const ThemeColorBottomSheet(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = Get.find<AppThemeController>();
    final maxHeight = MediaQuery.sizeOf(context).height * 0.92;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
            child: Row(
              children: [
                Text(
                  '앱 테마 색상',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '시드 색상',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 72,
            child: Obx(() {
              final selectedSeed = themeController.seedColor.value;
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: AppSeedColors.presets.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final preset = AppSeedColors.presets[index];
                  final selected =
                      preset.value.toARGB32() == selectedSeed.toARGB32();

                  return _SeedSwatch(
                    color: preset.value,
                    label: preset.label,
                    selected: selected,
                    onTap: () => themeController.setSeedColor(preset.value),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: Obx(
              () {
                final isDark = themeController.themeMode.value == ThemeMode.dark;
                final brightness =
                    isDark ? Brightness.dark : Brightness.light;
                final scheme = AppTheme.colorSchemeForSeed(
                  themeController.seedColor.value,
                  brightness,
                );

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDark ? '다크 ColorScheme' : '라이트 ColorScheme',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '동일 시드에서 ${isDark ? '다크' : '라이트'} 모드에 맞게 대칭 매핑된 색상입니다.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _ColorSchemePreviewGrid(scheme: scheme),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SeedSwatch extends StatelessWidget {
  const _SeedSwatch({
    required this.color,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outlineVariant,
                  width: selected ? 3 : 1,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorSchemePreviewGrid extends StatelessWidget {
  const _ColorSchemePreviewGrid({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final group in _previewGroups)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final entry in group.entries)
                      _ColorRoleChip(
                        label: entry.label,
                        color: entry.color(scheme),
                      ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ColorRoleEntry {
  const _ColorRoleEntry(this.label, this.color);

  final String label;
  final Color Function(ColorScheme scheme) color;
}

class _ColorRoleGroup {
  const _ColorRoleGroup(this.title, this.entries);

  final String title;
  final List<_ColorRoleEntry> entries;
}

final _previewGroups = <_ColorRoleGroup>[
  _ColorRoleGroup('Primary', [
    _ColorRoleEntry('primary', (s) => s.primary),
    _ColorRoleEntry('onPrimary', (s) => s.onPrimary),
    _ColorRoleEntry('primaryContainer', (s) => s.primaryContainer),
    _ColorRoleEntry('onPrimaryContainer', (s) => s.onPrimaryContainer),
  ]),
  _ColorRoleGroup('Secondary', [
    _ColorRoleEntry('secondary', (s) => s.secondary),
    _ColorRoleEntry('onSecondary', (s) => s.onSecondary),
    _ColorRoleEntry('secondaryContainer', (s) => s.secondaryContainer),
    _ColorRoleEntry('onSecondaryContainer', (s) => s.onSecondaryContainer),
  ]),
  _ColorRoleGroup('Tertiary', [
    _ColorRoleEntry('tertiary', (s) => s.tertiary),
    _ColorRoleEntry('onTertiary', (s) => s.onTertiary),
    _ColorRoleEntry('tertiaryContainer', (s) => s.tertiaryContainer),
    _ColorRoleEntry('onTertiaryContainer', (s) => s.onTertiaryContainer),
  ]),
  _ColorRoleGroup('Error', [
    _ColorRoleEntry('error', (s) => s.error),
    _ColorRoleEntry('onError', (s) => s.onError),
    _ColorRoleEntry('errorContainer', (s) => s.errorContainer),
    _ColorRoleEntry('onErrorContainer', (s) => s.onErrorContainer),
  ]),
  _ColorRoleGroup('Surface', [
    _ColorRoleEntry('surface', (s) => s.surface),
    _ColorRoleEntry('onSurface', (s) => s.onSurface),
    _ColorRoleEntry('surfaceContainerLowest', (s) => s.surfaceContainerLowest),
    _ColorRoleEntry('surfaceContainerLow', (s) => s.surfaceContainerLow),
    _ColorRoleEntry('surfaceContainer', (s) => s.surfaceContainer),
    _ColorRoleEntry('surfaceContainerHigh', (s) => s.surfaceContainerHigh),
    _ColorRoleEntry('surfaceContainerHighest', (s) => s.surfaceContainerHighest),
    _ColorRoleEntry('outline', (s) => s.outline),
    _ColorRoleEntry('outlineVariant', (s) => s.outlineVariant),
  ]),
];

class _ColorRoleChip extends StatelessWidget {
  const _ColorRoleChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onColor = ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : Colors.black87;
    final hex =
        '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';

    return Container(
      width: 160,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              hex,
              style: theme.textTheme.labelSmall?.copyWith(
                color: onColor,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
