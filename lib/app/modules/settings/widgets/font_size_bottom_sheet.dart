import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/font_scale_service.dart';
import '../../../core/theme/app_font_scale.dart';
import '../../../core/theme/app_theme_controller.dart';

class FontSizeBottomSheet extends StatelessWidget {
  const FontSizeBottomSheet({super.key});

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
        builder: (sheetContext) => const FontSizeBottomSheet(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final fontScaleService = Get.find<FontScaleService>();
    final themeController = Get.find<AppThemeController>();

    return Obx(() {
      final selected = fontScaleService.fontScale.value;
      final fontSizeFactor = selected.fontSizeFactor;
      final themeData = themeController.themeMode.value == ThemeMode.dark
          ? themeController.darkTheme
          : themeController.lightTheme;

      return Theme(
        data: themeData,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context);

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(fontSizeFactor),
              ),
              child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
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
                          '글자 크기',
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
                  for (final scale in AppFontScale.values)
                    ListTile(
                      title: Text(scale.label),
                      trailing: selected == scale
                          ? Icon(
                              Icons.check,
                              color: theme.colorScheme.primary,
                            )
                          : null,
                      onTap: () => fontScaleService.setFontScale(scale),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Text(
                      '실기 진행 화면에서 읽기 편한 글자 크기를 선택하세요.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '미리보기: 밀가루 250g을 체에 내려 준비합니다.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            );
          },
        ),
      );
    });
  }
}
