import 'package:get/get.dart';

import '../../progress_list/controllers/progress_list_controller.dart';
import '../../recipe/controllers/recipe_controller.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<RecipeController>(() => RecipeController());
    Get.lazyPut<ProgressListController>(() => ProgressListController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
