import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

import '../../data/models/practice_timer.dart';
import '../../data/models/progress_session.dart';
import '../../data/models/step_timer.dart';
import '../../data/repositories/timer_repository.dart';
import 'alarm_callback.dart';
import 'notification_service.dart';
import 'timer_alarm_handler.dart';

class TimerScheduleService extends GetxService {
  TimerScheduleService({
    TimerRepository? timerRepository,
    NotificationService? notificationService,
  })  : _timerRepository = timerRepository ?? TimerRepository(),
        _notificationService =
            notificationService ?? NotificationService.instance;

  final TimerRepository _timerRepository;
  final NotificationService _notificationService;
  final _uuid = const Uuid();

  final _displayByTimerId = <String, TimerDisplayContext>{};

  static Future<void> ensureInitialized() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    await NotificationService.instance.init();
    if (Platform.isAndroid) {
      await AndroidAlarmManager.initialize();
    }
  }

  TimerDisplayContext? displayContextFor(String timerId) =>
      _displayByTimerId[timerId];

  Future<List<PracticeTimer>> activeTimersForSession(String sessionId) {
    return _timerRepository.findActiveBySession(sessionId);
  }

  Future<PracticeTimer?> activeTimerForPreset({
    required String sessionId,
    required StepTimer preset,
  }) async {
    final active = await _timerRepository.findActiveBySession(sessionId);
    return _timerRepository.findActiveForPreset(
      activeTimers: active,
      type: preset.type,
      durationSec: preset.durationSec,
    );
  }

  Future<PracticeTimer> startTimer({
    required ProgressSession session,
    required int stepNo,
    required StepTimer preset,
    required String recipeName,
    bool notificationEnabled = true,
  }) async {
    final active = await _timerRepository.findActiveBySession(session.sessionId);
    final existing = _timerRepository.findActiveForPreset(
      activeTimers: active,
      type: preset.type,
      durationSec: preset.durationSec,
    );
    if (existing != null) {
      await cancelTimer(existing.timerId);
    }

    final now = DateTime.now();
    final endsAt = now.add(Duration(seconds: preset.durationSec));
    final timerId = _uuid.v4();
    final timer = PracticeTimer(
      timerId: timerId,
      sessionId: session.sessionId,
      type: preset.type,
      durationSec: preset.durationSec,
      startedAt: now,
      endsAt: endsAt,
      notificationEnabled: notificationEnabled,
    );

    await _timerRepository.upsert(timer);
    _displayByTimerId[timerId] = TimerDisplayContext(
      stepNo: stepNo,
      label: preset.label,
      recipeName: recipeName,
    );

    if (notificationEnabled) {
      await _schedulePlatform(
        timer: timer,
        recipeName: recipeName,
        timerLabel: preset.label,
      );
    }

    return timer;
  }

  Future<void> cancelTimer(String timerId) async {
    final alarmId = NotificationService.notificationIdFor(timerId);
    if (Platform.isAndroid) {
      await AndroidAlarmManager.cancel(alarmId);
      await _timerRepository.removeAlarmMapping(alarmId);
    }
    await _notificationService.cancelScheduled(alarmId);
    await _timerRepository.remove(timerId);
    _displayByTimerId.remove(timerId);
  }

  Future<void> _schedulePlatform({
    required PracticeTimer timer,
    required String recipeName,
    required String timerLabel,
  }) async {
    final notificationId = NotificationService.notificationIdFor(timer.timerId);

    if (Platform.isAndroid) {
      await _timerRepository.putAlarmMapping(notificationId, timer.timerId);
      await AndroidAlarmManager.oneShotAt(
        timer.endsAt,
        notificationId,
        onPracticeTimerAlarm,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      await _notificationService.scheduleTimerComplete(
        notificationId: notificationId,
        endsAt: timer.endsAt,
        recipeName: recipeName,
        timerLabel: timerLabel,
        payload: timer.timerId,
      );
    }
  }

  Future<void> syncExpiredTimers() async {
    final all = await _timerRepository.loadAll();
    final now = DateTime.now();
    for (final timer in all) {
      if (timer.endsAt.isAfter(now)) continue;
      await TimerAlarmHandler.handleTimerId(timer.timerId);
    }
  }
}
