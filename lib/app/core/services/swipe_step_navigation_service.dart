import 'package:get/get.dart';

import '../storage/swipe_step_preferences.dart';

/// 스와이프 단계 이동 설정 (앱 전역 reactive).
class SwipeStepNavigationService extends GetxService {
  SwipeStepNavigationService({
    required bool initialEnabled,
    SwipeStepPreferences? preferences,
  })  : _preferences = preferences ?? SwipeStepPreferences(),
        swipeStepNavigationEnabled = initialEnabled.obs;

  final SwipeStepPreferences _preferences;
  final RxBool swipeStepNavigationEnabled;

  Future<void> setEnabled(bool value) async {
    swipeStepNavigationEnabled.value = value;
    await _preferences.saveEnabled(value);
  }
}
