import 'package:get/get.dart';

import '../../../data/models/study_note.dart';
import '../../../data/repositories/recipe_repository.dart';
import '../../../data/repositories/study_note_repository.dart';

class KeyNoteDetailController extends GetxController {
  KeyNoteDetailController({
    StudyNoteRepository? studyRepository,
    RecipeRepository? recipeRepository,
  })  : _studyRepository = studyRepository ?? StudyNoteRepository(),
        _recipeRepository = recipeRepository ?? RecipeRepository();

  final StudyNoteRepository _studyRepository;
  final RecipeRepository _recipeRepository;

  final noteId = ''.obs;
  final noteTitle = ''.obs;
  final thumbnailUrl = ''.obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();
  final note = Rxn<StudyNote>();
  final openedFlashcardIndexes = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is String) {
      noteId.value = arg;
    }
    loadNote();
  }

  Future<void> loadNote() async {
    isLoading.value = true;
    errorMessage.value = null;
    note.value = null;
    openedFlashcardIndexes.clear();

    if (noteId.value.isEmpty) {
      errorMessage.value = '핵심노트 ID가 전달되지 않았습니다.';
      isLoading.value = false;
      return;
    }

    try {
      final selectedNote = await _studyRepository.loadStudyNote(noteId.value);
      if (selectedNote == null) {
        errorMessage.value = '핵심노트를 찾을 수 없습니다.';
        return;
      }

      note.value = selectedNote;
      final recipe = await _recipeRepository.findRecipeListItem(selectedNote.id);
      noteTitle.value = recipe?.name ?? selectedNote.id;
      thumbnailUrl.value = recipe?.thumbnailUrl ?? '';
    } catch (e) {
      errorMessage.value = '핵심노트를 불러오지 못했습니다.';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFlashcard(int index) {
    if (openedFlashcardIndexes.contains(index)) {
      openedFlashcardIndexes.remove(index);
    } else {
      openedFlashcardIndexes.add(index);
    }
    openedFlashcardIndexes.refresh();
  }
}
