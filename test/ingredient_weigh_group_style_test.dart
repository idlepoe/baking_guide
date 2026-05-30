import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:baking_guide/app/core/utils/ingredient_weigh_group_style.dart';
import 'package:baking_guide/app/data/models/ingredient_weigh_group.dart';
import 'package:baking_guide/app/data/models/recipe_ingredient.dart';
import 'package:baking_guide/app/data/models/enums/ingredient_category.dart';

void main() {
  test('assigns same color when weighGroupId shared by 2+ ingredients', () {
    const scheme = ColorScheme.light();
    final style = IngredientWeighGroupStyle(
      ingredients: const [
        RecipeIngredient(
          name: 'a',
          amount: 1,
          unit: 'g',
          category: IngredientCategory.flour,
          weighGroupId: 'dry',
        ),
        RecipeIngredient(
          name: 'b',
          amount: 1,
          unit: 'g',
          category: IngredientCategory.salt,
          weighGroupId: 'dry',
        ),
        RecipeIngredient(
          name: 'c',
          amount: 1,
          unit: 'g',
          category: IngredientCategory.liquid,
        ),
      ],
      weighGroups: const [
        IngredientWeighGroup(id: 'dry', label: '가루'),
      ],
      scheme: scheme,
    );

    expect(style.hasLegend, isTrue);
    final colorA = style.barColorFor(
      const RecipeIngredient(
        name: 'a',
        amount: 1,
        unit: 'g',
        category: IngredientCategory.flour,
        weighGroupId: 'dry',
      ),
    );
    final colorB = style.barColorFor(
      const RecipeIngredient(
        name: 'b',
        amount: 1,
        unit: 'g',
        category: IngredientCategory.salt,
        weighGroupId: 'dry',
      ),
    );
    expect(colorA, isNotNull);
    expect(colorA, colorB);
    expect(
      style.barColorFor(
        const RecipeIngredient(
          name: 'c',
          amount: 1,
          unit: 'g',
          category: IngredientCategory.liquid,
        ),
      ),
      isNull,
    );
  });
}
