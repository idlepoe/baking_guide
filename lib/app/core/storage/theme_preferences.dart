import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_seed_colors.dart';
/// 테마 관련 설정 영속화.
class ThemePreferences {
  static const _isDarkModeKey = 'is_dark_mode';
  static const _seedColorKey = 'seed_color';

  Future<bool> loadIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  Future<void> saveIsDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, value);
  }

  Future<Color> loadSeedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_seedColorKey);
    if (value == null) {
      return AppSeedColors.defaultSeed;
    }
    return Color(value);
  }

  Future<void> saveSeedColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_seedColorKey, color.toARGB32());
  }
}
