import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:baking_guide/app/data/models/recipe_detail.dart';
import 'package:baking_guide/app/data/models/recipe_list_item.dart';
import 'package:baking_guide/app/data/repositories/recipe_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const rawRecipeIds = [
    'pullman_bread',
    'chestnut_bread',
    'corn_bread',
    'butter_top',
    'butter_roll',
    'red_bean_bread',
    'pastry_twist',
    'soboro_bread',
    'cream_bread',
    'mocha_bread',
    'grissini',
    'whole_wheat_bread',
    'rye_bread',
    'sausage_bread',
    'bagel',
    'bread_donut',
    'rice_bread',
  ];

  group('RecipeListItem', () {
    test('parses recipe_list.json with 20 items', () async {
      final jsonString = await rootBundle.loadString(
        'assets/json/recipe_list.json',
      );
      final list = jsonDecode(jsonString) as List<dynamic>;
      final items = list
          .map((e) => RecipeListItem.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(items, hasLength(20));
      expect(items.every((e) => e.id.isNotEmpty), isTrue);
      final rawItems = items.where((e) => rawRecipeIds.contains(e.id));
      expect(
        rawItems.every((e) => e.thumbnailUrl.contains('/main.jpg')),
        isTrue,
      );
      expect(items.firstWhere((e) => e.id == 'sweet_roll').thumbnailUrl,
          contains('main.png'));
    });
  });

  group('RecipeDetail raw_images recipes', () {
    for (final id in rawRecipeIds) {
      test('parses $id.json', () async {
        final jsonString = await rootBundle.loadString(
          'assets/json/recipes/$id.json',
        );
        final detail = RecipeDetail.fromJson(
          jsonDecode(jsonString) as Map<String, dynamic>,
        );

        expect(detail.id, id);
        expect(detail.name, isNotEmpty);
        expect(detail.summary.examTimeSec, greaterThan(0));
        expect(detail.steps, isNotEmpty);
        expect(detail.thumbnailUrl, contains(id));
      });
    }
  });

  group('RecipeRepository', () {
    test('loadRecipeList and loadRecipeDetail for all raw recipes', () async {
      final repository = RecipeRepository();

      final list = await repository.loadRecipeList();
      expect(list.length, greaterThanOrEqualTo(20));

      for (final id in rawRecipeIds) {
        final detail = await repository.loadRecipeDetail(id);
        expect(detail, isNotNull, reason: id);
        expect(detail!.steps.isNotEmpty, isTrue);
      }

      expect(
        await repository.findRecipeListItem('unknown_recipe'),
        isNull,
      );
    });
  });
}
