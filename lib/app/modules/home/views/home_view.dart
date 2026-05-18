import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../progress_list/views/progress_list_view.dart';
import '../../recipe/views/recipe_view.dart';
import '../../settings/views/settings_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            RecipeView(),
            ProgressListView(),
            SettingsView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: '레시피',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: '진행',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }
}
