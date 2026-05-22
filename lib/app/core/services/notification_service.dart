import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../storage/timer_notification_preferences.dart';
import '../utils/duration_format.dart';
import 'timer_notify_log.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const _channelId = 'practice_timers';
  static const _channelName = '실기 타이머';
  static const _ongoingChannelId = 'practice_timers_running';
  static const _ongoingChannelName = '실기 타이머 (진행)';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
        macOS: darwinSettings,
      ),
    );

    if (Platform.isAndroid) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.createNotificationChannel(
        const AndroidNotificationChannel(
          _channelId,
          _channelName,
          importance: Importance.high,
        ),
      );
      await android?.createNotificationChannel(
        const AndroidNotificationChannel(
          _ongoingChannelId,
          _ongoingChannelName,
          importance: Importance.defaultImportance,
        ),
      );
    }

    _initialized = true;
  }

  Future<void> initFromBackground() async {
    await init();
  }

  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else if (Platform.isIOS || Platform.isMacOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, sound: true);
    }
  }

  Future<NotificationDetails> _completeDetails() async {
    final prefs = TimerNotificationPreferences();
    final vibrationEnabled = await prefs.loadVibrationEnabled();
    final soundOption = await prefs.loadSoundOption();
    final playSound = soundOption != TimerNotificationSound.silent;

    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: vibrationEnabled,
        playSound: playSound,
      ),
      iOS: DarwinNotificationDetails(
        presentSound: playSound,
      ),
      macOS: DarwinNotificationDetails(
        presentSound: playSound,
      ),
    );
  }

  /// 실행 중 타이머를 알림 바에 표시한다. Android는 chronometer로 남은 시간을 갱신한다.
  Future<void> showTimerOngoing({
    required String timerId,
    required DateTime endsAt,
    required String recipeName,
    required String timerLabel,
  }) async {
    await init();
    final remaining = endsAt.difference(DateTime.now());
    if (remaining.isNegative) return;

    final id = ongoingNotificationIdFor(timerId);
    await _plugin.show(
      id: id,
      title: recipeName,
      body: timerLabel,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _ongoingChannelId,
          _ongoingChannelName,
          channelDescription: '실기 타이머 진행 중 표시',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          ongoing: true,
          autoCancel: false,
          playSound: false,
          enableVibration: false,
          onlyAlertOnce: true,
          showWhen: true,
          when: endsAt.millisecondsSinceEpoch,
          usesChronometer: true,
          chronometerCountDown: true,
          category: AndroidNotificationCategory.progress,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: false,
          presentSound: false,
          presentBanner: false,
          subtitle: '남은 ${formatClockDuration(remaining)}',
          threadIdentifier: timerId,
        ),
        macOS: DarwinNotificationDetails(
          presentAlert: false,
          presentSound: false,
          subtitle: '남은 ${formatClockDuration(remaining)}',
          threadIdentifier: timerId,
        ),
      ),
      payload: timerId,
    );
  }

  Future<void> dismissTimerOngoing(String timerId) async {
    await init();
    await _plugin.cancel(id: ongoingNotificationIdFor(timerId));
  }

  Future<void> showTimerComplete({
    required int notificationId,
    required String recipeName,
    required String timerLabel,
  }) async {
    await init();
    TimerNotifyLog.d(
      'showTimerComplete id=$notificationId '
      'body=$recipeName · $timerLabel 완료',
    );
    try {
      await _plugin.show(
        id: notificationId,
        title: '타이머',
        body: '$recipeName · $timerLabel 완료',
        notificationDetails: await _completeDetails(),
      );
      TimerNotifyLog.d('showTimerComplete success id=$notificationId');
    } catch (e, st) {
      TimerNotifyLog.e(
        'showTimerComplete failed id=$notificationId',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<bool> scheduleTimerComplete({
    required int notificationId,
    required DateTime endsAt,
    required String recipeName,
    required String timerLabel,
    String? payload,
    AndroidScheduleMode androidScheduleMode =
        AndroidScheduleMode.exactAllowWhileIdle,
  }) async {
    await init();
    final scheduled = tz.TZDateTime.from(endsAt, tz.local);
    final now = tz.TZDateTime.now(tz.local);
    TimerNotifyLog.d(
      'scheduleTimerComplete id=$notificationId '
      'endsAt=${endsAt.toIso8601String()} scheduled=${scheduled.toIso8601String()} '
      'mode=$androidScheduleMode payload=$payload',
    );
    if (scheduled.isBefore(now)) {
      TimerNotifyLog.w(
        'scheduleTimerComplete endsAt already passed, showing immediately',
      );
      await showTimerComplete(
        notificationId: notificationId,
        recipeName: recipeName,
        timerLabel: timerLabel,
      );
      return true;
    }

    try {
      await _plugin.zonedSchedule(
        id: notificationId,
        title: '타이머',
        body: '$recipeName · $timerLabel 완료',
        scheduledDate: scheduled,
        notificationDetails: await _completeDetails(),
        androidScheduleMode: androidScheduleMode,
        payload: payload,
      );
      TimerNotifyLog.d(
        'scheduleTimerComplete success id=$notificationId at $scheduled',
      );
      return true;
    } catch (e, st) {
      TimerNotifyLog.e(
        'scheduleTimerComplete failed id=$notificationId',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }

  Future<void> cancelScheduled(int notificationId) async {
    await _plugin.cancel(id: notificationId);
  }

  static int notificationIdFor(String timerId) {
    return timerId.hashCode.abs() % 2147483647;
  }

  static int ongoingNotificationIdFor(String timerId) {
    return (timerId.hashCode ^ 0x6a09e667).abs() % 2147483647;
  }
}
