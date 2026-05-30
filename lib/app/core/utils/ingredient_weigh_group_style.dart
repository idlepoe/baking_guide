import 'package:flutter/material.dart';

import '../../data/models/ingredient_weigh_group.dart';
import '../../data/models/recipe_ingredient.dart';

/// 재료 계량 그룹별 UI 색·라벨 (2개 이상 재료가 같은 [weighGroupId]일 때만 색 부여).
class IngredientWeighGroupStyle {
  IngredientWeighGroupStyle({
    required List<RecipeIngredient> ingredients,
    required List<IngredientWeighGroup> weighGroups,
    required ColorScheme scheme,
  }) : _labels = {for (final g in weighGroups) g.id: g.label} {
    final counts = <String, int>{};
    for (final ingredient in ingredients) {
      final id = ingredient.weighGroupId;
      if (id == null || id.isEmpty) continue;
      counts[id] = (counts[id] ?? 0) + 1;
    }

    final palette = _paletteFor(scheme);
    var paletteIndex = 0;
    for (final entry in counts.entries) {
      if (entry.value < 2) continue;
      _colors[entry.key] = palette[paletteIndex % palette.length];
      paletteIndex++;
    }
  }

  final Map<String, String> _labels;
  final Map<String, Color> _colors = {};

  bool get hasLegend => _colors.isNotEmpty;

  Iterable<MapEntry<String, Color>> get legendEntries => _colors.entries;

  Color? barColorFor(RecipeIngredient ingredient) {
    final id = ingredient.weighGroupId;
    if (id == null || id.isEmpty) return null;
    return _colors[id];
  }

  String labelFor(String groupId) => _labels[groupId] ?? groupId;

  static List<Color> _paletteFor(ColorScheme scheme) => [
        scheme.primary,
        scheme.secondary,
        scheme.tertiary,
        scheme.primaryContainer,
        scheme.secondaryContainer,
        scheme.tertiaryContainer,
      ];
}
