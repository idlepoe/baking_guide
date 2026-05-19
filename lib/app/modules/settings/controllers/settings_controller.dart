import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/wakelock_service.dart';
import '../../../core/storage/screen_wake_preferences.dart';
import '../../../core/storage/theme_preferences.dart';
import '../../../core/theme/app_seed_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../widgets/theme_color_bottom_sheet.dart';

class SettingsController extends GetxController {
  SettingsController({
    ThemePreferences? themePreferences,
    ScreenWakePreferences? screenWakePreferences,
    WakelockService? wakelockService,
    AppThemeController? appThemeController,
  })  : _themePreferences = themePreferences ?? Get.find<ThemePreferences>(),
        _screenWakePreferences =
            screenWakePreferences ?? Get.find<ScreenWakePreferences>(),
        _wakelockService = wakelockService ?? Get.find<WakelockService>(),
        _appThemeController =
            appThemeController ?? Get.find<AppThemeController>();

  final ThemePreferences _themePreferences;
  final ScreenWakePreferences _screenWakePreferences;
  final WakelockService _wakelockService;
  final AppThemeController _appThemeController;

  final isDarkMode = false.obs;
  final keepScreenOn = false.obs;

  String get selectedSeedLabel {
    final seed = _appThemeController.seedColor.value;
    return AppSeedColors.labelFor(seed).label;
  }

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value =
        _appThemeController.themeMode.value == ThemeMode.dark;
    _syncFromStorage();
  }

  Future<void> _syncFromStorage() async {
    final storedDark = await _themePreferences.loadIsDarkMode();
    isDarkMode.value = storedDark;

    final mode = storedDark ? ThemeMode.dark : ThemeMode.light;
    if (_appThemeController.themeMode.value != mode) {
      _appThemeController.setThemeMode(mode);
    }

    final storedWake = await _screenWakePreferences.loadEnabled();
    keepScreenOn.value = storedWake;
    await _wakelockService.setEnabled(storedWake);
  }

  Future<void> setDarkMode(bool enabled) async {
    isDarkMode.value = enabled;
    _appThemeController.setThemeMode(
      enabled ? ThemeMode.dark : ThemeMode.light,
    );
    await _themePreferences.saveIsDarkMode(enabled);
  }

  Future<void> setKeepScreenOn(bool enabled) async {
    keepScreenOn.value = enabled;
    await _wakelockService.setEnabled(enabled);
    await _screenWakePreferences.saveEnabled(enabled);
  }

  void showThemeColorPicker(BuildContext context) {
    ThemeColorBottomSheet.show(context);
  }
}
