import 'package:get/get.dart';

import '../../../core/tutorial/progress_detail_route_args.dart';
import '../../../data/repositories/recipe_repository.dart';
import '../controllers/progress_detail_controller.dart';

class ProgressDetailBinding extends Bindings {
  @override
  void dependencies() {
    final args = ProgressDetailRouteArgs.parse(Get.arguments);
    if (Get.isRegistered<ProgressDetailController>()) {
      Get.delete<ProgressDetailController>(force: true);
    }
    Get.put(
      ProgressDetailController(
        recipeId: args.recipeId,
        runTutorialGuide: args.runTutorialGuide,
        repository: RecipeRepository(),
      ),
    );
  }
}
