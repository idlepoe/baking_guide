import 'enums/ingredient_category.dart';

/// 전 레시피에서 이름 기준으로 유니크한 재료 (보유 재료 목록용).
class CatalogIngredient {
  const CatalogIngredient({
    required this.name,
    required this.category,
  });

  final String name;
  final IngredientCategory category;
}
