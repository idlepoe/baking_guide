import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/font_scale_service.dart';
import '../storage/theme_preferences.dart';
import 'app_theme.dart';

class AppThemeController extends GetxService {
  AppThemeController({
    required Color initialSeed,
    required ThemeMode initialThemeMode,
    ThemePreferences? themePreferences,
    FontScaleService? fontScaleService,
  })  : _themePreferences = themePreferences ?? Get.find<ThemePreferences>(),
        _fontScaleService = fontScaleService ?? Get.find<FontScaleService>(),
        seedColor = initialSeed.obs,
        themeMode = initialThemeMode.obs;

  final ThemePreferences _themePreferences;
  final FontScaleService _fontScaleService;
  final Rx<Color> seedColor;
  final Rx<ThemeMode> themeMode;

  double get _fontSizeFactor =>
      _fontScaleService.fontScale.value.fontSizeFactor;

  ThemeData get lightTheme => AppTheme.fromSeed(
        seedColor.value,
        Brightness.light,
        fontSizeFactor: _fontSizeFactor,
      );

  ThemeData get darkTheme => AppTheme.fromSeed(
        seedColor.value,
        Brightness.dark,
        fontSizeFactor: _fontSizeFactor,
      );

  Future<void> setSeedColor(Color seed) async {
    seedColor.value = seed;
    await _themePreferences.saveSeedColor(seed);
  }

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }
}
