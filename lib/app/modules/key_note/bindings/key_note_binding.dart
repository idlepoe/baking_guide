import 'package:get/get.dart';

import '../controllers/key_note_controller.dart';

class KeyNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeyNoteController>(
      () => KeyNoteController(),
    );
  }
}
