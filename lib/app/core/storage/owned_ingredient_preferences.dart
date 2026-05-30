import 'package:shared_preferences/shared_preferences.dart';

/// 보유 재료 체크(재료명) 영속화.
class OwnedIngredientPreferences {
  static const _checkedNamesKey = 'owned_ingredient_checked_names';

  Future<Set<String>> loadCheckedNames() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_checkedNamesKey) ?? []).toSet();
  }

  Future<void> saveCheckedNames(Set<String> names) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_checkedNamesKey, names.toList()..sort());
  }
}
