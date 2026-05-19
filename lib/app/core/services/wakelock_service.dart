import 'package:wakelock_plus/wakelock_plus.dart';

/// 화면 꺼짐 방지(wakelock) 적용.
class WakelockService {
  Future<void> setEnabled(bool enabled) async {
    if (enabled) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }
}
