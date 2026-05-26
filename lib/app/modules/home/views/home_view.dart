import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../progress_list/views/progress_list_view.dart';
import '../../recipe/views/recipe_view.dart';
import '../../settings/views/settings_view.dart';
import '../controllers/home_controller.dart';
import '../widgets/active_timers_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _appBarTitles = ['레시피', '진행 중인 레시피', '설정'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(_appBarTitles[controller.currentIndex.value]),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ActiveTimersBar(),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.currentIndex.value,
                children: const [
                  RecipeView(),
                  ProgressListView(),
                  SettingsView(),
                ],
              ),
            ),
          ),
        ],
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
              label: '진행 중인 레시피',
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
