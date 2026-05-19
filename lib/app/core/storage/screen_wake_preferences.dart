import 'package:shared_preferences/shared_preferences.dart';

/// 화면 자동 꺼짐 방지 설정 영속화.
class ScreenWakePreferences {
  static const _enabledKey = 'screen_wake_lock_enabled';

  Future<bool> loadEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enabledKey) ?? false;
  }

  Future<void> saveEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, value);
  }
}
