import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/progress_detail/bindings/progress_detail_binding.dart';
import '../modules/progress_detail/views/progress_detail_view.dart';
import '../modules/progress_list/bindings/progress_list_binding.dart';
import '../modules/progress_list/views/progress_list_view.dart';
import '../modules/recipe/bindings/recipe_binding.dart';
import '../modules/recipe/views/recipe_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RECIPE,
      page: () => const RecipeView(),
      binding: RecipeBinding(),
    ),
    GetPage(
      name: _Paths.PROGRESS_LIST,
      page: () => const ProgressListView(),
      binding: ProgressListBinding(),
    ),
    GetPage(
      name: _Paths.PROGRESS_DETAIL,
      page: () => const ProgressDetailView(),
      binding: ProgressDetailBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
