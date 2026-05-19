import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/theme_preferences.dart';
import 'app_theme.dart';

class AppThemeController extends GetxService {
  AppThemeController({
    required Color initialSeed,
    required ThemeMode initialThemeMode,
    ThemePreferences? themePreferences,
  })  : _themePreferences = themePreferences ?? Get.find<ThemePreferences>(),
        seedColor = initialSeed.obs,
        themeMode = initialThemeMode.obs;

  final ThemePreferences _themePreferences;
  final Rx<Color> seedColor;
  final Rx<ThemeMode> themeMode;

  ThemeData get lightTheme => AppTheme.fromSeed(seedColor.value, Brightness.light);

  ThemeData get darkTheme => AppTheme.fromSeed(seedColor.value, Brightness.dark);

  Future<void> setSeedColor(Color seed) async {
    seedColor.value = seed;
    await _themePreferences.saveSeedColor(seed);
  }

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }
}
