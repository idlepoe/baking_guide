import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/storage/timer_notification_preferences.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../controllers/settings_controller.dart';

class NotificationSoundBottomSheet extends StatelessWidget {
  const NotificationSoundBottomSheet({super.key});

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
        builder: (sheetContext) => const NotificationSoundBottomSheet(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    final themeController = Get.find<AppThemeController>();

    return Obx(() {
      final selected = controller.notificationSound.value;
      final themeData = themeController.themeMode.value == ThemeMode.dark
          ? themeController.darkTheme
          : themeController.lightTheme;

      return Theme(
        data: themeData,
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context);

            return Padding(
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
                          '알림 소리',
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
                  for (final sound in TimerNotificationSound.values)
                    ListTile(
                      title: Text(sound.label),
                      trailing: selected == sound
                          ? Icon(
                              Icons.check,
                              color: theme.colorScheme.primary,
                            )
                          : null,
                      onTap: () => controller.setNotificationSound(sound),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Text(
                      '타이머 완료 알림에 적용됩니다. 진행 중 알림은 소리 없이 표시됩니다.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
