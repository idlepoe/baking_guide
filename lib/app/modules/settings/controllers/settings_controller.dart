import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
  }

  void setDarkMode(bool enabled) {
    isDarkMode.value = enabled;
    Get.changeThemeMode(enabled ? ThemeMode.dark : ThemeMode.light);
  }
}
