import 'package:shared_preferences/shared_preferences.dart';

/// 좌우 스와이프 단계 이동 설정 영속화.
class SwipeStepPreferences {
  static const _enabledKey = 'swipe_step_navigation_enabled';

  Future<bool> loadEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enabledKey) ?? true;
  }

  Future<void> saveEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, value);
  }
}
