import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_font_scale.dart';

/// 글자 크기 설정 영속화.
class FontScalePreferences {
  static const _fontScaleIdKey = 'font_scale_id';

  Future<AppFontScale> loadFontScale() async {
    final prefs = await SharedPreferences.getInstance();
    return AppFontScale.fromId(prefs.getString(_fontScaleIdKey));
  }

  Future<void> saveFontScale(AppFontScale scale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontScaleIdKey, scale.id);
  }
}
