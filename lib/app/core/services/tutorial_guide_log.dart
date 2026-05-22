import 'dart:developer' as developer;

import 'package:flutter/widgets.dart';

/// 사용 가이드(코치마크) 디버깅 로그. IDE/Logcat에서 `TutorialGuide` 필터.
abstract final class TutorialGuideLog {
  static const _name = 'TutorialGuide';

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

  static void keyState(String label, GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) {
      d('$label: key.currentContext=null (위젯 미빌드)');
      return;
    }
    final box = ctx.findRenderObject();
    final hasSize = box is RenderBox ? box.hasSize : false;
    d(
      '$label: mounted=${ctx.mounted} '
      'renderObject=${box.runtimeType} hasSize=$hasSize',
    );
  }
}
