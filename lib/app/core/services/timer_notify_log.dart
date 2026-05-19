import 'dart:developer' as developer;

/// 타이머 종료·로컬 알림 디버깅용 로그 (`TimerNotify` 필터).
abstract final class TimerNotifyLog {
  static const _name = 'TimerNotify';

  static void d(String message) {
    developer.log(message, name: _name);
  }

  static void w(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _name,
      level: 900,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
