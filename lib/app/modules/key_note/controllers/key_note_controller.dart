import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/models/recipe_list_item.dart';
import '../../../data/models/study_note.dart';
import '../../../data/repositories/recipe_repository.dart';
import '../../../data/repositories/study_note_repository.dart';

class KeyNoteController extends GetxController {
  KeyNoteController({
    StudyNoteRepository? studyRepository,
    RecipeRepository? recipeRepository,
  })  : _studyRepository = studyRepository ?? StudyNoteRepository(),
        _recipeRepository = recipeRepository ?? RecipeRepository();

  final StudyNoteRepository _studyRepository;
  final RecipeRepository _recipeRepository;

  final isLoading = true.obs;
  final items = <KeyNoteListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadKeyNotes();
  }

  Future<void> loadKeyNotes() async {
    isLoading.value = true;
    try {
      final studyList = await _studyRepository.loadStudyList();
      final recipes = await _recipeRepository.loadRecipeList();
      final recipeById = {for (final r in recipes) r.id: r};

      final notes = <StudyNote>[];
      for (final item in studyList) {
        final note = await _studyRepository.loadStudyNote(item.id);
        if (note != null) notes.add(note);
      }

      items.assignAll(
        notes.map((note) {
          final recipe = recipeById[note.id];
          return KeyNoteListItem(note: note, recipe: recipe);
        }).toList(),
      );
    } catch (e, stackTrace) {
      debugPrint('KeyNoteController.loadKeyNotes failed: $e\n$stackTrace');
      items.clear();
    } finally {
      isLoading.value = false;
    }
  }
}

@immutable
class KeyNoteListItem {
  const KeyNoteListItem({
    required this.note,
    required this.recipe,
  });

  final StudyNote note;
  final RecipeListItem? recipe;

  String get id => note.id;
  String get title => recipe?.name ?? note.id;
  String get thumbnailUrl => recipe?.thumbnailUrl ?? '';

  bool get hasSections => note.sections.isNotEmpty;
  bool get hasCommonMistakes => note.commonMistakes.isNotEmpty;
  bool get hasFlow => note.flow.isNotEmpty;
  bool get hasFlashcards => note.flashcards.isNotEmpty;
}
