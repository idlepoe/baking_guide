import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';

/// Android [AndroidAlarmManager] 백그라운드 isolate를 앱 프로세스당 1회만 준비한다.
///
/// `initialize()` 직후에는 native `AlarmService`가 아직 기동 중일 수 있어
/// `oneShotAt` 전에 짧은 대기를 둔다. Hot restart 후에는 native isolate가
/// 남아 있을 수 있으므로 알람 동작이 이상하면 앱을 완전히 재시작한다.
class AndroidAlarmBootstrap {
  AndroidAlarmBootstrap._();

  static Future<void>? _readyFuture;
  static bool _ready = false;

  static bool get isReady => _ready;

  static Future<void> ensureReady() async {
    if (!Platform.isAndroid) return;
    if (_ready) return;
    _readyFuture ??= _warmUp();
    await _readyFuture!;
  }

  static Future<void> _warmUp() async {
    final ok = await AndroidAlarmManager.initialize();
    if (!ok) {
      if (kDebugMode) {
        debugPrint('AndroidAlarmBootstrap: initialize() returned false');
      }
      return;
    }

    // 백그라운드 isolate가 AlarmService.initialized 를 보낼 때까지 여유.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _ready = true;
  }
}
