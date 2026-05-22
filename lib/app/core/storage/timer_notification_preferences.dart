import 'package:shared_preferences/shared_preferences.dart';

/// 타이머 완료 알림 소리 옵션.
enum TimerNotificationSound {
  defaultSound('default'),
  silent('silent');

  const TimerNotificationSound(this.storageValue);

  final String storageValue;

  static TimerNotificationSound fromStorage(String? value) {
    return TimerNotificationSound.values.firstWhere(
      (e) => e.storageValue == value,
      orElse: () => TimerNotificationSound.defaultSound,
    );
  }

  String get label => switch (this) {
        TimerNotificationSound.defaultSound => '기본',
        TimerNotificationSound.silent => '무음',
      };
}

/// 타이머 알림·진동·소리 설정 영속화.
class TimerNotificationPreferences {
  static const _notificationsEnabledKey = 'timer_notifications_enabled';
  static const _vibrationEnabledKey = 'timer_vibration_enabled';
  static const _soundOptionKey = 'timer_notification_sound';

  Future<bool> loadNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  Future<void> saveNotificationsEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, value);
  }

  Future<bool> loadVibrationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_vibrationEnabledKey) ?? true;
  }

  Future<void> saveVibrationEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_vibrationEnabledKey, value);
  }

  Future<TimerNotificationSound> loadSoundOption() async {
    final prefs = await SharedPreferences.getInstance();
    return TimerNotificationSound.fromStorage(
      prefs.getString(_soundOptionKey),
    );
  }

  Future<void> saveSoundOption(TimerNotificationSound value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_soundOptionKey, value.storageValue);
  }
}
