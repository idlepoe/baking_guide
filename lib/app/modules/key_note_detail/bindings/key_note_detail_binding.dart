import 'package:get/get.dart';

import '../controllers/key_note_detail_controller.dart';

class KeyNoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeyNoteDetailController>(
      () => KeyNoteDetailController(),
    );
  }
}
