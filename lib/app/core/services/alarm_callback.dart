import 'timer_alarm_handler.dart';
import 'timer_notify_log.dart';

@pragma('vm:entry-point')
Future<void> onPracticeTimerAlarm(int alarmId) async {
  TimerNotifyLog.d('onPracticeTimerAlarm fired alarmId=$alarmId');
  try {
    await TimerAlarmHandler.handleAlarm(alarmId);
    TimerNotifyLog.d('onPracticeTimerAlarm finished alarmId=$alarmId');
  } catch (e, st) {
    TimerNotifyLog.e(
      'onPracticeTimerAlarm failed alarmId=$alarmId',
      error: e,
      stackTrace: st,
    );
    rethrow;
  }
}
