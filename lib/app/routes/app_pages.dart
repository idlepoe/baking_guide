import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/key_note/bindings/key_note_binding.dart';
import '../modules/key_note/views/key_note_view.dart';
import '../modules/key_note_detail/bindings/key_note_detail_binding.dart';
import '../modules/key_note_detail/views/key_note_detail_view.dart';
import '../modules/progress_detail/bindings/progress_detail_binding.dart';
import '../modules/progress_detail/views/progress_detail_view.dart';

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
      name: _Paths.PROGRESS_DETAIL,
      page: () => const ProgressDetailView(),
      binding: ProgressDetailBinding(),
    ),
    GetPage(
      name: _Paths.KEY_NOTE,
      page: () => const KeyNoteView(),
      binding: KeyNoteBinding(),
    ),
    GetPage(
      name: _Paths.KEY_NOTE_DETAIL,
      page: () => const KeyNoteDetailView(),
      binding: KeyNoteDetailBinding(),
    ),
  ];
}
