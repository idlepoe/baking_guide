import '../../data/models/enums/ingredient_category.dart';

/// category 섹션·정렬용 고정 순서.
const ingredientCategorySortOrder = <IngredientCategory>[
  IngredientCategory.flour,
  IngredientCategory.powder,
  IngredientCategory.sweetener,
  IngredientCategory.salt,
  IngredientCategory.yeast,
  IngredientCategory.improver,
  IngredientCategory.liquid,
  IngredientCategory.liquidOptional,
  IngredientCategory.egg,
  IngredientCategory.fat,
  IngredientCategory.filling,
  IngredientCategory.spice,
];

int ingredientCategorySortIndex(IngredientCategory category) {
  final index = ingredientCategorySortOrder.indexOf(category);
  return index >= 0 ? index : ingredientCategorySortOrder.length;
}

String formatIngredientCategory(IngredientCategory category) {
  return switch (category) {
    IngredientCategory.flour => '밀가루',
    IngredientCategory.liquid => '액체',
    IngredientCategory.sweetener => '당류',
    IngredientCategory.salt => '소금류',
    IngredientCategory.yeast => '이스트',
    IngredientCategory.fat => '유지',
    IngredientCategory.filling => '충전·토핑',
    IngredientCategory.improver => '개량제',
    IngredientCategory.liquidOptional => '액체(선택)',
    IngredientCategory.powder => '분말',
    IngredientCategory.egg => '달걀',
    IngredientCategory.spice => '향신료',
  };
}
