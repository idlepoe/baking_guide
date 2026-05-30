import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:baking_guide/app/data/models/enums/exam_type.dart';
import 'package:baking_guide/app/data/models/recipe_list_item.dart';
import 'package:baking_guide/app/modules/recipe/controllers/recipe_controller.dart';
import 'package:baking_guide/app/modules/recipe/views/recipe_view.dart';

void main() {
  testWidgets('Recipe tab shows items from recipe_list.json', (
    WidgetTester tester,
  ) async {
    Get.testMode = true;
    final controller = RecipeController();
    Get.put(controller);
    controller.isLoading.value = false;
    controller.examTypeFilter.value = ExamType.baking;
    controller.recipes.assignAll([
      const RecipeListItem(
        id: 'chestnut_bread',
        name: '밤식빵',
        category: 'bread',
        examType: ExamType.baking,
        thumbnailUrl: 'assets/images/recipes/chestnut_bread/main.jpg',
        difficulty: 2,
        totalTimeSec: 13200,
      ),
      const RecipeListItem(
        id: 'soboro_bread',
        name: '소보로빵',
        category: 'pastry',
        examType: ExamType.baking,
        thumbnailUrl: 'assets/images/recipes/soboro_bread/main.jpg',
        difficulty: 3,
        totalTimeSec: 10800,
      ),
    ]);

    await tester.pumpWidget(
      const GetMaterialApp(home: RecipeView()),
    );
    await tester.pump();

    expect(find.text('제빵'), findsOneWidget);
    expect(find.text('제과'), findsOneWidget);
    expect(find.text('밤식빵'), findsOneWidget);
    expect(find.text('소보로빵'), findsOneWidget);
    expect(find.text('3시간 40분'), findsOneWidget);
    expect(find.text('3시간'), findsOneWidget);

    Get.reset();
  });
}
