import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_bar_labeled_icon_action.dart';
import '../controllers/recipe_controller.dart';

/// 레시피 탭 AppBar actions — [HomeView]에서 index 0일 때 사용.
class RecipeAppBarActions {
  RecipeAppBarActions._();

  static Widget buildAction(BuildContext context) {
    if (!Get.isRegistered<RecipeController>()) {
      return const SizedBox.shrink();
    }

    final recipeController = Get.find<RecipeController>();
    return Obx(
      () => AppBarLabeledIconAction(
        icon: Icons.inventory_2_outlined,
        label: '보유 재료',
        pendingCount: recipeController.ownedIngredientUncheckedCount,
        showCompletedBadge: recipeController.allOwnedIngredientsChecked,
        onPressed: () => recipeController.openOwnedIngredientsSheet(context),
      ),
    );
  }
}
