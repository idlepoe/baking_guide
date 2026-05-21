import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/enums/timer_kind.dart';
import '../models/practice_timer.dart';

class TimerRepository {
  static const _timersKey = 'practice_timers';
  static const _alarmMapKey = 'timer_alarm_map';

  Future<List<PracticeTimer>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_timersKey);
    if (raw == null || raw.isEmpty) return [];

    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => PracticeTimer.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveAll(List<PracticeTimer> timers) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(timers.map((t) => t.toJson()).toList());
    await prefs.setString(_timersKey, encoded);
  }

  Future<void> upsert(PracticeTimer timer) async {
    final timers = await loadAll();
    final index = timers.indexWhere((t) => t.timerId == timer.timerId);
    if (index >= 0) {
      timers[index] = timer;
    } else {
      timers.add(timer);
    }
    await saveAll(timers);
  }

  Future<void> remove(String timerId) async {
    final timers = await loadAll();
    timers.removeWhere((t) => t.timerId == timerId);
    await saveAll(timers);
  }

  Future<PracticeTimer?> findByTimerId(String timerId) async {
    final timers = await loadAll();
    for (final timer in timers) {
      if (timer.timerId == timerId) return timer;
    }
    return null;
  }

  Future<List<PracticeTimer>> findBySessionId(String sessionId) async {
    final timers = await loadAll();
    return timers.where((t) => t.sessionId == sessionId).toList();
  }

  Future<List<PracticeTimer>> findActiveBySession(String sessionId) async {
    final now = DateTime.now();
    final timers = await findBySessionId(sessionId);
    return timers.where((t) => t.endsAt.isAfter(now)).toList();
  }

  Future<List<PracticeTimer>> findAllActive() async {
    final now = DateTime.now();
    final timers = await loadAll();
    return timers.where((t) => t.endsAt.isAfter(now)).toList();
  }

  PracticeTimer? findActiveForPreset({
    required List<PracticeTimer> activeTimers,
    required TimerKind type,
    required int durationSec,
  }) {
    for (final timer in activeTimers) {
      if (timer.type == type && timer.durationSec == durationSec) {
        return timer;
      }
    }
    return null;
  }

  Future<Map<int, String>> loadAlarmMap() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_alarmMapKey);
    if (raw == null || raw.isEmpty) return {};

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map(
      (key, value) => MapEntry(int.parse(key), value as String),
    );
  }

  Future<void> saveAlarmMap(Map<int, String> map) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      map.map((key, value) => MapEntry(key.toString(), value)),
    );
    await prefs.setString(_alarmMapKey, encoded);
  }

  Future<void> putAlarmMapping(int alarmId, String timerId) async {
    final map = await loadAlarmMap();
    map[alarmId] = timerId;
    await saveAlarmMap(map);
  }

  Future<void> removeAlarmMapping(int alarmId) async {
    final map = await loadAlarmMap();
    map.remove(alarmId);
    await saveAlarmMap(map);
  }

  Future<String?> findTimerIdByAlarmId(int alarmId) async {
    final map = await loadAlarmMap();
    return map[alarmId];
  }
}
