import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/services/wakelock_service.dart';
import 'app/core/storage/screen_wake_preferences.dart';
import 'app/core/storage/theme_preferences.dart';
import 'app/core/theme/app_theme_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themePreferences = ThemePreferences();
  final screenWakePreferences = ScreenWakePreferences();
  final wakelockService = WakelockService();

  final isDarkMode = await themePreferences.loadIsDarkMode();
  final seedColor = await themePreferences.loadSeedColor();
  final keepScreenOn = await screenWakePreferences.loadEnabled();

  Get.put(themePreferences, permanent: true);
  Get.put(screenWakePreferences, permanent: true);
  Get.put(wakelockService, permanent: true);
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

    return Obx(
      () => GetMaterialApp(
        title: 'Application',
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode: themeController.themeMode.value,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
