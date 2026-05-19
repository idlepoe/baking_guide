import 'package:get/get.dart';

import '../storage/font_scale_preferences.dart';
import '../theme/app_font_scale.dart';

/// 글자 크기 설정 (앱 전역 reactive).
class FontScaleService extends GetxService {
  FontScaleService({
    required AppFontScale initialScale,
    FontScalePreferences? preferences,
  })  : _preferences = preferences ?? FontScalePreferences(),
        fontScale = initialScale.obs;

  final FontScalePreferences _preferences;
  final Rx<AppFontScale> fontScale;

  Future<void> setFontScale(AppFontScale scale) async {
    fontScale.value = scale;
    await _preferences.saveFontScale(scale);
  }
}
