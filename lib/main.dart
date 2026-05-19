import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/data/repositories/progress_session_repository.dart';
import 'app/data/repositories/timer_repository.dart';
import 'app/core/services/font_scale_service.dart';
import 'app/core/services/timer_schedule_service.dart';
import 'app/core/services/swipe_step_navigation_service.dart';
import 'app/core/services/wakelock_service.dart';
import 'app/core/storage/font_scale_preferences.dart';
import 'app/core/storage/screen_wake_preferences.dart';
import 'app/core/storage/swipe_step_preferences.dart';
import 'app/core/storage/theme_preferences.dart';
import 'app/core/theme/app_theme_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TimerScheduleService.ensureInitialized();

  final themePreferences = ThemePreferences();
  final screenWakePreferences = ScreenWakePreferences();
  final swipeStepPreferences = SwipeStepPreferences();
  final fontScalePreferences = FontScalePreferences();
  final wakelockService = WakelockService();

  final isDarkMode = await themePreferences.loadIsDarkMode();
  final seedColor = await themePreferences.loadSeedColor();
  final keepScreenOn = await screenWakePreferences.loadEnabled();
  final swipeStepEnabled = await swipeStepPreferences.loadEnabled();
  final initialFontScale = await fontScalePreferences.loadFontScale();

  Get.put(ProgressSessionRepository(), permanent: true);
  Get.put(TimerRepository(), permanent: true);
  Get.put(TimerScheduleService(), permanent: true);
  Get.put(themePreferences, permanent: true);
  Get.put(screenWakePreferences, permanent: true);
  Get.put(swipeStepPreferences, permanent: true);
  Get.put(wakelockService, permanent: true);
  Get.put(
    SwipeStepNavigationService(initialEnabled: swipeStepEnabled),
    permanent: true,
  );
  Get.put(
    FontScaleService(initialScale: initialFontScale),
    permanent: true,
  );
  Get.put(
    AppThemeController(
      initialSeed: seedColor,
      initialThemeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    ),
    permanent: true,
  );

  if (keepScreenOn) {
    await wakelockService.setEnabled(true);
  }

  runApp(const BakingGuideApp());
}

class BakingGuideApp extends StatelessWidget {
  const BakingGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<AppThemeController>();

    final fontScaleService = Get.find<FontScaleService>();

    return Obx(
      () {
        final _ = fontScaleService.fontScale.value;
        return GetMaterialApp(
          title: 'Application',
          theme: themeController.lightTheme,
          darkTheme: themeController.darkTheme,
          themeMode: themeController.themeMode.value,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
