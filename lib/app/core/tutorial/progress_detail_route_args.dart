/// [Routes.PROGRESS_DETAIL] 라우트 인자.
///
/// 기존 `String` recipeId 호환 + 사용 가이드 튜토리얼 플래그.
class ProgressDetailRouteArgs {
  const ProgressDetailRouteArgs({
    required this.recipeId,
    this.runTutorialGuide = false,
  });

  final String recipeId;
  final bool runTutorialGuide;

  static ProgressDetailRouteArgs parse(dynamic arguments) {
    if (arguments is ProgressDetailRouteArgs) return arguments;
    if (arguments is String) {
      return ProgressDetailRouteArgs(recipeId: arguments);
    }
    if (arguments is Map) {
      final id = arguments['recipeId'] as String? ?? '';
      final guide = arguments['runTutorialGuide'] as bool? ?? false;
      return ProgressDetailRouteArgs(recipeId: id, runTutorialGuide: guide);
    }
    return const ProgressDetailRouteArgs(recipeId: '');
  }
}
