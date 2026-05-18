part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const PROGRESS_DETAIL = _Paths.PROGRESS_DETAIL;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const PROGRESS_DETAIL = '/progress-detail';
}
