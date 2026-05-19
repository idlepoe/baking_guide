import 'dart:io';

import 'package:flutter/widgets.dart';

import '../../data/models/practice_timer.dart';
import '../../data/models/progress_session.dart';
import '../../data/models/recipe_detail.dart';
import '../../data/repositories/progress_session_repository.dart';
import '../../data/repositories/recipe_repository.dart';
import '../../data/repositories/timer_repository.dart';
import 'notification_service.dart';

class TimerDisplayContext {
  const TimerDisplayContext({
    required this.stepNo,
    required this.label,
    required this.recipeName,
  });

  final int stepNo;
  final String label;
  final String recipeName;
}

class TimerAlarmHandler {
  static Future<void> handleAlarm(int alarmId) async {
    WidgetsFlutterBinding.ensureInitialized();

    final timerRepo = TimerRepository();
    final timerId = await timerRepo.findTimerIdByAlarmId(alarmId);
    if (timerId == null) return;

    await _completeTimer(timerId, timerRepo);
  }

  static Future<void> handleTimerId(String timerId) async {
    WidgetsFlutterBinding.ensureInitialized();
    await _completeTimer(timerId, TimerRepository());
  }

  static Future<void> _completeTimer(
    String timerId,
    TimerRepository timerRepo,
  ) async {
    final timer = await timerRepo.findByTimerId(timerId);
    if (timer == null) return;

    final context = await resolveDisplayContext(timer);
    final recipeName = context?.recipeName ?? '레시피';
    final label = context?.label ?? _fallbackLabel(timer);

    // iOS는 zonedSchedule로 이미 알림이 예약·표시되므로, 동기화 시에는 제거만 한다.
    if (timer.notificationEnabled && Platform.isAndroid) {
      final notificationId = NotificationService.notificationIdFor(timerId);
      await NotificationService.instance.showTimerComplete(
        notificationId: notificationId,
        recipeName: recipeName,
        timerLabel: label,
      );
    }

    final alarmId = NotificationService.notificationIdFor(timerId);
    await timerRepo.remove(timerId);
    await timerRepo.removeAlarmMapping(alarmId);
    await NotificationService.instance.cancelScheduled(alarmId);
  }

  static Future<TimerDisplayContext?> resolveDisplayContext(
    PracticeTimer timer,
  ) async {
    final sessions = await ProgressSessionRepository().loadAll();
    ProgressSession? session;
    for (final s in sessions) {
      if (s.sessionId == timer.sessionId) {
        session = s;
        break;
      }
    }
    if (session == null) return null;

    final recipe = await RecipeRepository().loadRecipeDetail(session.recipeId);
    if (recipe == null) {
      return TimerDisplayContext(
        stepNo: session.currentStepNo,
        label: _fallbackLabel(timer),
        recipeName: session.recipeId,
      );
    }

    final label = _labelFromRecipe(timer, recipe, session.currentStepNo) ??
        _fallbackLabel(timer);

    return TimerDisplayContext(
      stepNo: session.currentStepNo,
      label: label,
      recipeName: recipe.name,
    );
  }

  static String? _labelFromRecipe(
    PracticeTimer timer,
    RecipeDetail recipe,
    int preferredStepNo,
  ) {
    for (final step in recipe.steps) {
      if (step.stepNo != preferredStepNo) continue;
      for (final stepTimer in step.timers) {
        if (stepTimer.type == timer.type &&
            stepTimer.durationSec == timer.durationSec) {
          return stepTimer.label;
        }
      }
    }
    for (final step in recipe.steps) {
      for (final stepTimer in step.timers) {
        if (stepTimer.type == timer.type &&
            stepTimer.durationSec == timer.durationSec) {
          return stepTimer.label;
        }
      }
    }
    return null;
  }

  static String _fallbackLabel(PracticeTimer timer) {
    return switch (timer.type.name) {
      'fermentation' => '발효 타이머',
      'exam' => '시험 타이머',
      _ => '단계 타이머',
    };
  }
}
