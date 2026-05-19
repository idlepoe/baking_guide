import 'timer_alarm_handler.dart';

@pragma('vm:entry-point')
Future<void> onPracticeTimerAlarm(int alarmId) async {
  await TimerAlarmHandler.handleAlarm(alarmId);
}
