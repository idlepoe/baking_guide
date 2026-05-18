import 'package:get/get.dart';

import '../controllers/progress_detail_controller.dart';

class ProgressDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgressDetailController>(
      () => ProgressDetailController(),
    );
  }
}
