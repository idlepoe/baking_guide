import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchPreferences {
  static const _isFirstLaunchKey = 'app_is_first_launch';

  Future<bool> loadIsFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstLaunchKey) ?? true;
  }

  Future<void> saveIsFirstLaunch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstLaunchKey, value);
  }
}
