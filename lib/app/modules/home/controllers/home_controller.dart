import 'package:get/get.dart';

import '../../progress_list/controllers/progress_list_controller.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
    if (index == 1 && Get.isRegistered<ProgressListController>()) {
      Get.find<ProgressListController>().loadSessions();
    }
  }
}
