import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/enums/exam_type.dart';

/// 레시피 목록 시험 분류(제빵/제과) 필터 선택 영속화.
class RecipeExamTypeFilterPreferences {
  static const _examTypeFilterKey = 'recipe_exam_type_filter';

  Future<ExamType> loadExamTypeFilter() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_examTypeFilterKey);
    return switch (value) {
      'confectionery' => ExamType.confectionery,
      _ => ExamType.baking,
    };
  }

  Future<void> saveExamTypeFilter(ExamType examType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_examTypeFilterKey, examType.name);
  }
}
