import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Android 12+ `SCHEDULE_EXACT_ALARM` 런타임 허용 여부.
abstract final class ExactAlarmPermission {
  static Future<bool> isGranted() async {
    if (!Platform.isAndroid) return true;
    return Permission.scheduleExactAlarm.isGranted;
  }

  /// 설정 화면으로 이동할 수 있으며, 허용 시 `true`.
  static Future<bool> request() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.scheduleExactAlarm.request();
    return status.isGranted;
  }

  /// 타이머 시작 전 호출. 미허용이면 설정 요청을 시도한다.
  static Future<bool> ensureGranted() async {
    if (await isGranted()) return true;
    return request();
  }

  static Future<void> openSettings() => openAppSettings();
}
