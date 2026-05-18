import 'package:get/get.dart';

import '../controllers/progress_list_controller.dart';

class ProgressListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgressListController>(
      () => ProgressListController(),
    );
  }
}
