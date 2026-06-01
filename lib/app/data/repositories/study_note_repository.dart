import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/study_list_item.dart';
import '../models/study_note.dart';

class StudyNoteRepository {
  static const _studyListPath = 'assets/json/study_list.json';
  static const _studyDetailPath = 'assets/json/studies';

  Future<List<StudyListItem>> loadStudyList() async {
    try {
      final jsonString = await rootBundle.loadString(_studyListPath);
      final list = jsonDecode(jsonString) as List<dynamic>;
      return list
          .map((e) => StudyListItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      debugPrint('StudyNoteRepository.loadStudyList failed: $e\n$stackTrace');
      return [];
    }
  }

  Future<StudyNote?> loadStudyNote(String id) async {
    try {
      final jsonString =
          await rootBundle.loadString('$_studyDetailPath/$id.json');
      return StudyNote.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
    } catch (e, stackTrace) {
      debugPrint(
        'StudyNoteRepository.loadStudyNote($id) failed: $e\n$stackTrace',
      );
      return null;
    }
  }

  Future<List<StudyNote>> loadAllStudyNotes() async {
    final list = await loadStudyList();
    final notes = <StudyNote>[];
    for (final item in list) {
      final note = await loadStudyNote(item.id);
      if (note != null) notes.add(note);
    }
    return notes;
  }
}
