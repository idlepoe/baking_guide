import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const _channelId = 'practice_timers';
  static const _channelName = '실기 타이머';

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
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              _channelId,
              _channelName,
              importance: Importance.high,
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

  NotificationDetails _details() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showTimerComplete({
    required int notificationId,
    required String recipeName,
    required String timerLabel,
  }) async {
    await init();
    await _plugin.show(
      id: notificationId,
      title: '타이머',
      body: '$recipeName · $timerLabel 완료',
      notificationDetails: _details(),
    );
  }

  Future<void> scheduleTimerComplete({
    required int notificationId,
    required DateTime endsAt,
    required String recipeName,
    required String timerLabel,
    String? payload,
  }) async {
    await init();
    final scheduled = tz.TZDateTime.from(endsAt, tz.local);
    if (scheduled.isBefore(tz.TZDateTime.now(tz.local))) {
      await showTimerComplete(
        notificationId: notificationId,
        recipeName: recipeName,
        timerLabel: timerLabel,
      );
      return;
    }

    await _plugin.zonedSchedule(
      id: notificationId,
      title: '타이머',
      body: '$recipeName · $timerLabel 완료',
      scheduledDate: scheduled,
      notificationDetails: _details(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  Future<void> cancelScheduled(int notificationId) async {
    await _plugin.cancel(id: notificationId);
  }

  static int notificationIdFor(String timerId) {
    return timerId.hashCode.abs() % 2147483647;
  }
}
