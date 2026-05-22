import 'package:shared_preferences/shared_preferences.dart';

import '../utils/ingredient_format.dart';

/// 레시피별 재료 배합 배율 슬라이더 인덱스 영속화.
class IngredientBatchScalePreferences {
  static const _keyPrefix = 'ingredient_batch_scale_index_';

  static String _key(String recipeId) => '$_keyPrefix$recipeId';

  Future<int> loadScaleIndex(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getInt(_key(recipeId));
    if (stored == null) {
      return IngredientBatchScale.exam.index;
    }
    return stored.clamp(0, IngredientBatchScale.values.length - 1);
  }

  Future<void> saveScaleIndex(String recipeId, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      _key(recipeId),
      index.clamp(0, IngredientBatchScale.values.length - 1),
    );
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs
        .getKeys()
        .where((key) => key.startsWith(_keyPrefix))
        .toList();
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}
