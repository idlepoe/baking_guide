import 'package:get/get.dart';

import '../../../core/services/timer_schedule_service.dart';
import '../../progress_list/controllers/progress_list_controller.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  @override
  void onReady() {
    super.onReady();
    Get.find<TimerScheduleService>().refreshActiveEntries();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    Get.find<TimerScheduleService>().refreshActiveEntries();
    if (index == 1 && Get.isRegistered<ProgressListController>()) {
      Get.find<ProgressListController>().loadSessions();
    }
  }
}
