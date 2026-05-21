import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

import '../models/active_timer_entry.dart';
import '../../data/models/practice_timer.dart';
import '../../data/models/progress_session.dart';
import '../../data/models/step_timer.dart';
import '../../data/repositories/progress_session_repository.dart';
import '../../data/repositories/timer_repository.dart';
import 'alarm_callback.dart';
import 'android_alarm_bootstrap.dart';
import 'exact_alarm_permission.dart';
import 'notification_service.dart';
import 'timer_alarm_handler.dart';
import 'timer_notify_log.dart';

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

  /// Home 상단 등에서 구독하는 진행 중 타이머 목록.
  final activeEntries = <ActiveTimerEntry>[].obs;

  Timer? _expiryWatcher;
  bool _expirySyncInFlight = false;

  @override
  void onInit() {
    super.onInit();
    Future.microtask(_bootstrapActiveTimers);
  }

  @override
  void onClose() {
    _stopExpiryWatcher();
    super.onClose();
  }

  static Future<void> ensureInitialized() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    await NotificationService.instance.init();
    if (Platform.isAndroid) {
      await AndroidAlarmBootstrap.ensureReady();
    }
  }

  static Future<bool> prepareAndroidScheduling() async {
    if (!Platform.isAndroid) return true;
    return ExactAlarmPermission.ensureGranted();
  }

  TimerDisplayContext? displayContextFor(String timerId) =>
      _displayByTimerId[timerId];

  /// 전역 진행 중 타이머를 조회해 [activeEntries]를 갱신한다.
  Future<void> refreshActiveEntries() async {
    final timers = await _timerRepository.findAllActive();
    final now = DateTime.now();
    timers.sort((a, b) => a.endsAt.compareTo(b.endsAt));

    final sessions = await _loadSessionsMap();
    final entries = <ActiveTimerEntry>[];

    for (final timer in timers) {
      if (!timer.endsAt.isAfter(now)) continue;

      final session = sessions[timer.sessionId];
      final recipeId = session?.recipeId ?? '';
      final memCtx = _displayByTimerId[timer.timerId];

      if (memCtx != null) {
        entries.add(
          ActiveTimerEntry(
            timer: timer,
            recipeName: memCtx.recipeName,
            label: memCtx.label,
            recipeId: recipeId,
          ),
        );
        continue;
      }

      final ctx = await TimerAlarmHandler.resolveDisplayContext(timer);
      entries.add(
        ActiveTimerEntry(
          timer: timer,
          recipeName: ctx?.recipeName ?? '레시피',
          label: ctx?.label ?? TimerAlarmHandler.fallbackLabel(timer),
          recipeId: recipeId,
        ),
      );
    }

    activeEntries.assignAll(entries);
  }

  Future<Map<String, ProgressSession>> _loadSessionsMap() async {
    final repo = Get.isRegistered<ProgressSessionRepository>()
        ? Get.find<ProgressSessionRepository>()
        : ProgressSessionRepository();
    final sessions = await repo.loadAll();
    return {for (final s in sessions) s.sessionId: s};
  }

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

  /// 타이머를 저장하고 플랫폼 알람/알림을 예약한다. 실패 시 롤백 후 `false`.
  Future<bool> startTimer({
    required ProgressSession session,
    required int stepNo,
    required StepTimer preset,
    required String recipeName,
    bool notificationEnabled = true,
  }) async {
    if (notificationEnabled) {
      await _notificationService.requestPermissions();
      if (Platform.isAndroid) {
        await ExactAlarmPermission.ensureGranted();
      }
    }

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

    if (!notificationEnabled) {
      TimerNotifyLog.d('startTimer timerId=$timerId notifications disabled');
      await _ensureExpiryWatcherRunning();
      await refreshActiveEntries();
      return true;
    }

    TimerNotifyLog.d(
      'startTimer timerId=$timerId endsAt=${endsAt.toIso8601String()} '
      'durationSec=${preset.durationSec} label=${preset.label}',
    );
    final scheduled = await _schedulePlatform(
      timer: timer,
      recipeName: recipeName,
      timerLabel: preset.label,
    );
    if (!scheduled) {
      TimerNotifyLog.w('startTimer schedule failed, rolling back timerId=$timerId');
      await cancelTimer(timerId);
      return false;
    }

    await _showOngoingForTimer(
      timer: timer,
      recipeName: recipeName,
      timerLabel: preset.label,
    );
    await _ensureExpiryWatcherRunning();
    await refreshActiveEntries();
    return true;
  }

  Future<void> cancelTimer(String timerId) async {
    final alarmId = NotificationService.notificationIdFor(timerId);
    await _notificationService.dismissTimerOngoing(timerId);
    if (Platform.isAndroid) {
      await AndroidAlarmManager.cancel(alarmId);
      await _timerRepository.removeAlarmMapping(alarmId);
    }
    await _notificationService.cancelScheduled(alarmId);
    await _timerRepository.remove(timerId);
    _displayByTimerId.remove(timerId);
    await _ensureExpiryWatcherRunning();
    await refreshActiveEntries();
  }

  Future<bool> _schedulePlatform({
    required PracticeTimer timer,
    required String recipeName,
    required String timerLabel,
  }) async {
    final notificationId = NotificationService.notificationIdFor(timer.timerId);

    if (Platform.isAndroid) {
      await _timerRepository.putAlarmMapping(notificationId, timer.timerId);
      final canExact = await ExactAlarmPermission.isGranted();
      TimerNotifyLog.d(
        '_schedulePlatform Android timerId=${timer.timerId} '
        'notificationId=$notificationId canExact=$canExact '
        'bootstrapReady=${AndroidAlarmBootstrap.isReady}',
      );

      var alarmOk = false;
      await AndroidAlarmBootstrap.ensureReady();
      if (AndroidAlarmBootstrap.isReady) {
        if (canExact) {
          alarmOk = await AndroidAlarmManager.oneShotAt(
            timer.endsAt,
            notificationId,
            onPracticeTimerAlarm,
            exact: true,
            wakeup: true,
            rescheduleOnReboot: true,
          );
        } else {
          alarmOk = await AndroidAlarmManager.oneShotAt(
            timer.endsAt,
            notificationId,
            onPracticeTimerAlarm,
            exact: false,
            allowWhileIdle: true,
            wakeup: true,
            rescheduleOnReboot: false,
          );
        }
        TimerNotifyLog.d(
          '_schedulePlatform oneShotAt alarmOk=$alarmOk exact=$canExact',
        );
      } else {
        TimerNotifyLog.w('_schedulePlatform skipped AlarmManager (not ready)');
      }

      final notifOk = await _notificationService.scheduleTimerComplete(
        notificationId: notificationId,
        endsAt: timer.endsAt,
        recipeName: recipeName,
        timerLabel: timerLabel,
        payload: timer.timerId,
        androidScheduleMode: canExact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
      );

      TimerNotifyLog.d(
        '_schedulePlatform result alarmOk=$alarmOk notifOk=$notifOk',
      );
      return alarmOk || notifOk;
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return _notificationService.scheduleTimerComplete(
        notificationId: notificationId,
        endsAt: timer.endsAt,
        recipeName: recipeName,
        timerLabel: timerLabel,
        payload: timer.timerId,
      );
    }
    return true;
  }

  Future<void> syncExpiredTimers() async {
    final all = await _timerRepository.loadAll();
    final now = DateTime.now();
    var expiredCount = 0;
    for (final timer in all) {
      if (timer.endsAt.isAfter(now)) continue;
      expiredCount++;
      TimerNotifyLog.d(
        'syncExpiredTimers expired timerId=${timer.timerId} '
        'endsAt=${timer.endsAt.toIso8601String()}',
      );
      await TimerAlarmHandler.handleTimerId(timer.timerId);
    }
    if (expiredCount > 0) {
      TimerNotifyLog.d('syncExpiredTimers handled $expiredCount expired timer(s)');
    }
    await refreshOngoingNotifications();
    await _ensureExpiryWatcherRunning();
    await refreshActiveEntries();
  }

  Future<void> _bootstrapActiveTimers() async {
    await syncExpiredTimers();
    await _ensureExpiryWatcherRunning();
    await refreshActiveEntries();
  }

  Future<void> _ensureExpiryWatcherRunning() async {
    final all = await _timerRepository.loadAll();
    final now = DateTime.now();
    final hasActive = all.any((t) => t.endsAt.isAfter(now));
    if (hasActive) {
      _startExpiryWatcher();
    } else {
      _stopExpiryWatcher();
    }
  }

  void _startExpiryWatcher() {
    if (_expiryWatcher != null) return;
    TimerNotifyLog.d('expiryWatcher started');
    _expiryWatcher = Timer.periodic(
      const Duration(seconds: 1),
      (_) => unawaited(_tickExpiryWatcher()),
    );
  }

  void _stopExpiryWatcher() {
    if (_expiryWatcher == null) return;
    TimerNotifyLog.d('expiryWatcher stopped');
    _expiryWatcher?.cancel();
    _expiryWatcher = null;
  }

  Future<void> _tickExpiryWatcher() async {
    if (_expirySyncInFlight) return;
    _expirySyncInFlight = true;
    try {
      await syncExpiredTimers();
    } finally {
      _expirySyncInFlight = false;
    }
  }

  /// 앱 재시작·동기화 후 실행 중 타이머 알림을 복구한다.
  Future<void> refreshOngoingNotifications() async {
    final all = await _timerRepository.loadAll();
    final now = DateTime.now();
    for (final timer in all) {
      if (!timer.notificationEnabled || !timer.endsAt.isAfter(now)) {
        await _notificationService.dismissTimerOngoing(timer.timerId);
        continue;
      }
      final ctx = _displayByTimerId[timer.timerId] ??
          await TimerAlarmHandler.resolveDisplayContext(timer);
      await _showOngoingForTimer(
        timer: timer,
        recipeName: ctx?.recipeName ?? '레시피',
        timerLabel: ctx?.label ?? TimerAlarmHandler.fallbackLabel(timer),
      );
    }
  }

  Future<void> _showOngoingForTimer({
    required PracticeTimer timer,
    required String recipeName,
    required String timerLabel,
  }) async {
    if (!timer.notificationEnabled) return;
    await _notificationService.showTimerOngoing(
      timerId: timer.timerId,
      endsAt: timer.endsAt,
      recipeName: recipeName,
      timerLabel: timerLabel,
    );
  }
}
