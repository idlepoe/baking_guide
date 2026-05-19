import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/enums/progress_session_status.dart';
import '../models/progress_session.dart';

class ProgressSessionRepository {
  static const _storageKey = 'progress_sessions';

  Future<List<ProgressSession>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];

    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => ProgressSession.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveAll(List<ProgressSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(sessions.map((s) => s.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> upsert(ProgressSession session) async {
    final sessions = await loadAll();
    final index = sessions.indexWhere((s) => s.sessionId == session.sessionId);
    if (index >= 0) {
      sessions[index] = session;
    } else {
      sessions.add(session);
    }
    await saveAll(sessions);
  }

  Future<ProgressSession?> findInProgressByRecipeId(String recipeId) async {
    final sessions = await loadAll();
    for (final session in sessions) {
      if (session.recipeId == recipeId &&
          session.status == ProgressSessionStatus.inProgress) {
        return session;
      }
    }
    return null;
  }

  Future<List<ProgressSession>> listActiveForUi() async {
    final sessions = await loadAll();
    final filtered = sessions
        .where(
          (s) =>
              s.status == ProgressSessionStatus.inProgress ||
              s.status == ProgressSessionStatus.completed,
        )
        .toList();
    filtered.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return filtered;
  }
}
