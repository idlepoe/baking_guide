import 'package:shared_preferences/shared_preferences.dart';

/// 레시피 북마크(품목 id) 영속화. 앞쪽일수록 최근 북마크.
class RecipeBookmarkPreferences {
  static const _bookmarkIdsKey = 'recipe_bookmark_ids';

  Future<List<String>> loadBookmarkedIdsOrdered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_bookmarkIdsKey) ?? [];
  }

  Future<void> saveBookmarkedIdsOrdered(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bookmarkIdsKey, ids);
  }

  Future<void> addBookmark(String recipeId) async {
    final ids = await loadBookmarkedIdsOrdered()..remove(recipeId);
    ids.insert(0, recipeId);
    await saveBookmarkedIdsOrdered(ids);
  }

  Future<void> removeBookmark(String recipeId) async {
    final ids = await loadBookmarkedIdsOrdered()..remove(recipeId);
    await saveBookmarkedIdsOrdered(ids);
  }
}
