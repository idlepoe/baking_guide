import 'dart:developer' as developer;

/// ActiveTimersBar 탭 → 실기 화면 이동 디버깅 (`ActiveTimersNav` 필터).
abstract final class ActiveTimersNavLog {
  static const _name = 'ActiveTimersNav';

  static void d(String message) {
    developer.log(message, name: _name);
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
