part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const PROGRESS_DETAIL = _Paths.PROGRESS_DETAIL;
  static const KEY_NOTE = _Paths.KEY_NOTE;
  static const KEY_NOTE_DETAIL = _Paths.KEY_NOTE_DETAIL;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const PROGRESS_DETAIL = '/progress-detail';
  static const KEY_NOTE = '/key-note';
  static const KEY_NOTE_DETAIL = '/key-note-detail';
}
