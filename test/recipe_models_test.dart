import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:baking_guide/app/data/models/enums/mixing_method.dart';
import 'package:baking_guide/app/data/models/enums/timer_kind.dart';
import 'package:baking_guide/app/data/models/recipe_detail.dart';
import 'package:baking_guide/app/data/models/recipe_list_item.dart';
import 'package:baking_guide/app/data/repositories/recipe_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RecipeListItem', () {
    test('parses recipe_list.json', () async {
      final jsonString = await rootBundle.loadString(
        'assets/json/recipe_list.json',
      );
      final list = jsonDecode(jsonString) as List<dynamic>;
      final items = list
          .map((e) => RecipeListItem.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(items, hasLength(4));
      expect(items.first.id, 'chestnut_bread');
      expect(items.first.name, '밤식빵');
      expect(items.first.totalTimeSec, 13200);
      expect(items[1].id, 'milk_bread');
      expect(items[2].totalTimeSec, 9600);
      expect(items[3].id, 'sweet_roll');
    });
  });

  group('RecipeDetail', () {
    test('parses chestnut_bread.json with structured fields', () async {
      final jsonString = await rootBundle.loadString(
        'assets/json/recipes/chestnut_bread.json',
      );
      final detail = RecipeDetail.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );

      expect(detail.id, 'chestnut_bread');
      expect(detail.name, '밤식빵');
      expect(detail.summary.examTimeSec, 13200);
      expect(detail.summary.mixingMethod, MixingMethod.straight);
      expect(detail.summary.oven.top, 170);
      expect(detail.steps, hasLength(5));
      expect(detail.steps[1].checklist.first.id, 'cleanup_done');
      expect(detail.steps[1].calculators.first.type.name, 'doughTemp');
      expect(detail.steps[4].timers.first.type, TimerKind.fermentation);
      expect(detail.resultEvaluation.first.id, 'uniform_loaves');
    });
  });

  group('RecipeRepository', () {
    test('loadRecipeList and loadRecipeDetail', () async {
      final repository = RecipeRepository();

      final list = await repository.loadRecipeList();
      expect(list, isNotEmpty);

      final detail = await repository.loadRecipeDetail('chestnut_bread');
      expect(detail, isNotNull);
      expect(detail!.steps.isNotEmpty, isTrue);

      final missing = await repository.loadRecipeDetail('unknown_recipe');
      expect(missing, isNull);
    });
  });
}
