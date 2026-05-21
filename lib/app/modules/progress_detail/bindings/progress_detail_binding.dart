import 'package:get/get.dart';

import '../../../data/repositories/recipe_repository.dart';
import '../controllers/progress_detail_controller.dart';

class ProgressDetailBinding extends Bindings {
  @override
  void dependencies() {
    final recipeId = Get.arguments as String? ?? '';
    if (Get.isRegistered<ProgressDetailController>()) {
      Get.delete<ProgressDetailController>(force: true);
    }
    Get.put(
      ProgressDetailController(
        recipeId: recipeId,
        repository: RecipeRepository(),
      ),
    );
  }
}
