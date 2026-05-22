import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../data/models/enums/progress_session_status.dart';
import '../../data/repositories/progress_session_repository.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../modules/progress_detail/controllers/progress_detail_controller.dart';
import '../../modules/progress_detail/widgets/dough_temp_calculator_bottom_sheet.dart';
import '../../modules/progress_detail/widgets/ingredients_bottom_sheet.dart';
import '../../modules/progress_detail/widgets/timer_bottom_sheet.dart';
import '../../routes/app_pages.dart';
import '../tutorial/progress_detail_route_args.dart';
import '../tutorial/tutorial_guide_keys.dart';
import 'timer_schedule_service.dart';
import 'tutorial_guide_log.dart';

class TutorialGuideService extends GetxService {
  bool isActive = false;
  bool _detailPhasesStarted = false;

  Future<void> startFromSettings() async {
    TutorialGuideLog.d('startFromSettings: isActive=$isActive');
    if (isActive) {
      TutorialGuideLog.w('startFromSettings: 이미 실행 중 — 무시');
      return;
    }
    isActive = true;

    try {
      await _goHomeRecipeTab();
      await _cleanupDemoSession(popDetail: false);
      await _runPhaseRecipe();
      TutorialGuideLog.d(
        'startFromSettings: 레시피 페이즈 완료 — 상세 화면에서 튜토리얼 이어짐',
      );
    } catch (error, stackTrace) {
      TutorialGuideLog.e(
        'startFromSettings: 예외로 튜토리얼 중단',
        error: error,
        stackTrace: stackTrace,
      );
      await _finishTutorial(popDetail: false);
    }
  }

  Future<void> _goHomeRecipeTab() async {
    final startRoute = Get.currentRoute;
    TutorialGuideLog.d('_goHomeRecipeTab: 시작 route=$startRoute');

    var backCount = 0;
    while (Get.currentRoute != Routes.HOME) {
      TutorialGuideLog.d('_goHomeRecipeTab: Get.back() (route=${Get.currentRoute})');
      Get.back();
      backCount++;
      if (backCount > 20) {
        TutorialGuideLog.w('_goHomeRecipeTab: back 20회 초과 — 중단');
        break;
      }
    }
    TutorialGuideLog.d('_goHomeRecipeTab: backCount=$backCount route=${Get.currentRoute}');

    if (Get.isRegistered<HomeController>()) {
      final home = Get.find<HomeController>();
      final before = home.currentIndex.value;
      home.changeIndex(0);
      TutorialGuideLog.d('_goHomeRecipeTab: tab $before → 0 (레시피)');
    } else {
      TutorialGuideLog.w('_goHomeRecipeTab: HomeController 미등록');
    }

    await Future.delayed(const Duration(milliseconds: 300));
    _logContext('after tab switch');
    await _waitForKey(
      TutorialGuideKeys.recipeCard,
      label: 'recipeCard',
      required: true,
    );
  }

  /// 시트·다이얼로그용 — 현재 라우트 Navigator 컨텍스트.
  BuildContext? get _routeContext {
    final nav = Get.key.currentContext;
    if (nav != null && nav.mounted) return nav;
    final ctx = Get.context;
    if (ctx != null && ctx.mounted) return ctx;
    return null;
  }

  void _logContext(String phase) {
    final navKey = Get.key;
    final navOverlay = navKey.currentState?.overlay;
    final routeCtx = Get.context;
    TutorialGuideLog.d(
      '_logContext[$phase]: currentRoute=${Get.currentRoute} '
      'navigatorOverlay=${navOverlay != null ? "ok" : "null"} '
      'routeContext=${routeCtx != null ? "ok(mounted=${routeCtx.mounted})" : "null"} '
      'getOverlayContext=${Get.overlayContext != null ? "set(_Theater, 코치마크에 사용 금지)" : "null"}',
    );
  }

  /// [tutorial_coach_mark]는 Overlay.of가 가능한 컨텍스트가 필요함.
  /// Get.overlayContext는 _Theater라서 show() 시 예외가 난다.
  void _presentCoachMark(
    TutorialCoachMark coachMark,
    String phase, {
    bool rootOverlay = true,
    BuildContext? presentationContext,
  }) {
    if (presentationContext != null && presentationContext.mounted) {
      TutorialGuideLog.d(
        '_presentCoachMark[$phase]: show(modal context, rootOverlay=false)',
      );
      coachMark.show(context: presentationContext, rootOverlay: false);
      return;
    }

    final navigatorKey = Get.key;
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay != null) {
      TutorialGuideLog.d(
        '_presentCoachMark[$phase]: showWithNavigatorStateKey '
        '(rootOverlay=$rootOverlay)',
      );
      coachMark.showWithNavigatorStateKey(
        navigatorKey: navigatorKey,
        rootOverlay: rootOverlay,
      );
      return;
    }

    final ctx = Get.context;
    if (ctx == null || !ctx.mounted) {
      throw FlutterError(
        '_presentCoachMark[$phase]: Navigator·route context 없음',
      );
    }
    TutorialGuideLog.d(
      '_presentCoachMark[$phase]: show(context, rootOverlay=$rootOverlay)',
    );
    coachMark.show(context: ctx, rootOverlay: rootOverlay);
  }

  /// 모달 시트·바텀시트 위 타깃용 — 첫 번째 [GlobalKey]의 context로 좌표 계산.
  BuildContext? _modalPresentationContext(List<TargetFocus> targets) {
    for (final target in targets) {
      final ctx = target.keyTarget?.currentContext;
      if (ctx != null && ctx.mounted) return ctx;
    }
    return null;
  }

  Future<void> _runPhaseRecipe() async {
    TutorialGuideLog.d('_runPhaseRecipe: 시작');
    TutorialGuideLog.keyState('recipeCard', TutorialGuideKeys.recipeCard);
    TutorialGuideLog.keyState('recipeBookmark', TutorialGuideKeys.recipeBookmark);

    await _showCoachMark(
      phase: 'recipe',
      targets: [
        _target(
          identify: 'recipe_select',
          key: TutorialGuideKeys.recipeCard,
          align: ContentAlign.bottom,
          title: '레시피 선택',
          body:
              '레시피 카드를 탭하면 상세 화면으로 이동합니다.\n튜토리얼에서는 스위트롤 레시피를 사용합니다.',
        ),
        _target(
          identify: 'recipe_bookmark',
          key: TutorialGuideKeys.recipeBookmark,
          align: ContentAlign.left,
          title: '즐겨찾기',
          body: '북마크 아이콘을 눌러 자주 쓰는 레시피를 즐겨찾기에 추가할 수 있습니다.',
        ),
      ],
      onFinish: () {
        TutorialGuideLog.d(
          '_runPhaseRecipe onFinish: 상세 이동 (${TutorialGuideKeys.demoRecipeId}) '
          'runTutorialGuide=true (Get.toNamed는 await하지 않음)',
        );
        // GetX: await Get.toNamed는 상세가 pop될 때까지 대기하므로 사용 금지.
        Get.toNamed(
          Routes.PROGRESS_DETAIL,
          arguments: ProgressDetailRouteArgs(
            recipeId: TutorialGuideKeys.demoRecipeId,
            runTutorialGuide: true,
          ),
        );
      },
    );
  }

  /// [ProgressDetailController]에서 레시피 로드 후 호출.
  Future<void> startDetailPhases() async {
    if (_detailPhasesStarted) {
      TutorialGuideLog.w('startDetailPhases: 이미 실행 중');
      return;
    }
    if (Get.currentRoute != Routes.PROGRESS_DETAIL) {
      TutorialGuideLog.w(
        'startDetailPhases: route=${Get.currentRoute} — 중단',
      );
      return;
    }
    _detailPhasesStarted = true;
    TutorialGuideLog.d('startDetailPhases: 상세 튜토리얼 시작');

    try {
      await _prepareDetailForTutorial();
      if (!isActive) return;
      await _runPhasePracticeStart();
      if (!isActive) return;
      TutorialGuideLog.d('startDetailPhases: 상세 튜토리얼 완료');
    } catch (error, stackTrace) {
      TutorialGuideLog.e(
        'startDetailPhases: 예외',
        error: error,
        stackTrace: stackTrace,
      );
      await _finishTutorial(popDetail: false);
    } finally {
      _detailPhasesStarted = false;
    }
  }

  /// 상세 화면 튜토리얼: 진행 중 세션 제거 → 「실기 시작」버튼 노출.
  Future<void> _prepareDetailForTutorial() async {
    TutorialGuideLog.d('_prepareDetailForTutorial: 시작');
    _logDetailSessionState('before cleanup');

    await _cleanupDemoSession(popDetail: false);
    await _waitForUiFrames(2);
    _logDetailSessionState('after cleanup');

    final hasKey = await _waitForKey(
      TutorialGuideKeys.practiceStart,
      label: 'practiceStart',
      required: false,
    );
    if (!hasKey) {
      TutorialGuideLog.e(
        '_prepareDetailForTutorial: practiceStart 키 없음 — '
        '진행 중 세션이 남았거나 UI 미빌드. route=${Get.currentRoute}',
      );
      await _finishTutorial(popDetail: false);
    }
  }

  void _logDetailSessionState(String label) {
    if (!Get.isRegistered<ProgressDetailController>()) {
      TutorialGuideLog.d('_logDetailSessionState[$label]: controller 미등록');
      return;
    }
    final c = Get.find<ProgressDetailController>();
    final status = c.session.value?.status;
    TutorialGuideLog.d(
      '_logDetailSessionState[$label]: recipeId=${c.recipeId} '
      'isLoading=${c.isLoading.value} hasActiveSession=${c.hasActiveSession} '
      'sessionStatus=$status route=${Get.currentRoute}',
    );
    TutorialGuideLog.keyState('practiceStart', TutorialGuideKeys.practiceStart);
    TutorialGuideLog.keyState('timerFab', TutorialGuideKeys.timerFab);
    TutorialGuideLog.keyState('doughTempFab', TutorialGuideKeys.doughTempFab);
    TutorialGuideLog.keyState('nextStep', TutorialGuideKeys.nextStep);
  }

  Future<void> _scrollTargetIntoView(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    try {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        alignment: 0.35,
      );
    } catch (error, stackTrace) {
      TutorialGuideLog.w(
        '_scrollTargetIntoView: 실패',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _waitForUiFrames(int count) async {
    for (var i = 0; i < count; i++) {
      await Future<void>.delayed(Duration.zero);
      await WidgetsBinding.instance.endOfFrame;
      if (!isActive) return;
    }
  }

  Future<void> _runPhasePracticeStart() async {
    TutorialGuideLog.d('_runPhasePracticeStart: 시작');
    if (TutorialGuideKeys.practiceStart.currentContext == null) {
      TutorialGuideLog.e('_runPhasePracticeStart: practiceStart 없음 — 중단');
      return;
    }

    await _showCoachMark(
      phase: 'practice_start',
      targets: [
        _target(
          identify: 'practice_start',
          key: TutorialGuideKeys.practiceStart,
          align: ContentAlign.top,
          title: '실기 시작',
          body: '실기를 시작하면 단계별 가이드와 타이머를 사용할 수 있습니다.',
          shape: ShapeLightFocus.RRect,
          radius: 8,
        ),
      ],
      onFinish: () async {
        TutorialGuideLog.d('_runPhasePracticeStart onFinish: startPractice');
        if (!Get.isRegistered<ProgressDetailController>()) {
          TutorialGuideLog.w('ProgressDetailController 미등록');
          return;
        }
        final controller = Get.find<ProgressDetailController>();
        await controller.startPractice();
        await Future.delayed(const Duration(milliseconds: 500));
        final ctx = _routeContext;
        if (ctx == null || !ctx.mounted || !isActive) {
          TutorialGuideLog.w(
            '_runPhasePracticeStart: 재료 시트 생략 '
            '(ctx=${ctx == null ? "null" : "mounted=${ctx.mounted}"} isActive=$isActive)',
          );
          return;
        }
        IngredientsBottomSheet.show(ctx, controller);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (isActive) unawaited(_runPhaseIngredients());
        });
      },
    );
  }

  Future<void> _runPhaseIngredients() async {
    TutorialGuideLog.d('_runPhaseIngredients: 시작');
    await _waitForKey(
      TutorialGuideKeys.batchSlider,
      label: 'batchSlider',
      required: true,
    );
    if (!isActive) return;

    // 시트 슬라이드 애니메이션·레이아웃 안정화 후 좌표 측정
    await Future.delayed(const Duration(milliseconds: 350));
    await _waitForUiFrames(2);
    if (!isActive) return;

    await _showCoachMark(
      phase: 'ingredients',
      useModalOverlay: true,
      targets: [
        _target(
          identify: 'batch_slider',
          key: TutorialGuideKeys.batchSlider,
          align: ContentAlign.bottom,
          title: '배합 비율 조절',
          body: '슬라이더로 시험·연습·1/2 배합 비율을 바꿀 수 있습니다.',
          paddingFocus: 6,
          radius: 6,
        ),
        _target(
          identify: 'ingredient_check',
          key: TutorialGuideKeys.firstIngredientCheck,
          align: ContentAlign.bottom,
          title: '재료 체크',
          body: '계량한 재료를 탭해 체크하세요. 모든 재료를 확인한 뒤 닫을 수 있습니다.',
        ),
        _target(
          identify: 'ingredients_close',
          key: TutorialGuideKeys.ingredientsClose,
          align: ContentAlign.top,
          title: '확인',
          body: '하단의 닫기 버튼을 눌러 재료 목록을 닫고 단계 화면으로 돌아갑니다.',
          shape: ShapeLightFocus.RRect,
          radius: 8,
        ),
      ],
      onFinish: () async {
        TutorialGuideLog.d('_runPhaseIngredients onFinish: 시트 닫기');
        await _closeIngredientsSheetIfOpen();
        if (!isActive) return;
        await _runPhaseTimerFab();
      },
    );
  }

  Future<void> _runPhaseTimerFab() async {
    TutorialGuideLog.d('_runPhaseTimerFab: 시작');
    await _closeIngredientsSheetIfOpen();
    if (!isActive) return;

    await _waitForKey(
      TutorialGuideKeys.timerFab,
      label: 'timerFab',
      required: true,
    );
    if (!isActive) return;

    await _showCoachMark(
      phase: 'timer_fab',
      targets: [
        _target(
          identify: 'timer_fab',
          key: TutorialGuideKeys.timerFab,
          align: ContentAlign.top,
          title: '타이머',
          body: '타이머 버튼을 눌러 전체·단계·공정 타이머를 확인하고 시작할 수 있습니다.',
          shape: ShapeLightFocus.Circle,
        ),
      ],
      onFinish: () async {
        TutorialGuideLog.d('_runPhaseTimerFab onFinish: goToStep + 타이머 시트');
        if (!Get.isRegistered<ProgressDetailController>()) {
          TutorialGuideLog.w('ProgressDetailController 미등록');
          return;
        }
        final controller = Get.find<ProgressDetailController>();
        await controller.goToStep(TutorialGuideKeys.demoFermentationStepIndex);
        final ctx = _routeContext;
        if (ctx == null || !ctx.mounted || !isActive) {
          TutorialGuideLog.w('_runPhaseTimerFab: ctx 없음 — 이후 단계 생략');
          return;
        }

        await TimerBottomSheet.runWhileOpen(
          ctx,
          controller,
          _runPhaseFermentationTimer,
        );
        if (!isActive) return;
        await Future.delayed(const Duration(milliseconds: 200));
        await _waitForUiFrames(1);
        if (!isActive) return;
        await _runPhaseDoughTemp();
        if (!isActive) return;
        await _runPhaseNextStep();
      },
    );
  }

  Future<void> _runPhaseDoughTemp() async {
    TutorialGuideLog.d('_runPhaseDoughTemp: 시작');
    if (!Get.isRegistered<ProgressDetailController>()) return;
    final controller = Get.find<ProgressDetailController>();

    if (Get.currentRoute != Routes.PROGRESS_DETAIL) {
      TutorialGuideLog.e(
        '_runPhaseDoughTemp: 상세 화면이 닫혀 있음 route=${Get.currentRoute}',
      );
      await _finishTutorial(popDetail: false);
      return;
    }

    await controller.goToStep(TutorialGuideKeys.demoDoughTempStepIndex);
    await _waitForUiFrames(2);
    if (!isActive) return;

    await _waitForKey(
      TutorialGuideKeys.doughTempFab,
      label: 'doughTempFab',
      required: true,
    );
    if (!isActive) return;

    await _showCoachMark(
      phase: 'dough_temp_fab',
      targets: [
        _target(
          identify: 'dough_temp_fab',
          key: TutorialGuideKeys.doughTempFab,
          align: ContentAlign.top,
          title: '반죽온도',
          body: '반죽온도 버튼으로 목표 온도와 권장 물 온도를 계산할 수 있습니다.',
          shape: ShapeLightFocus.Circle,
        ),
      ],
      onFinish: () async {
        TutorialGuideLog.d('_runPhaseDoughTemp onFinish: 계산기 시트');
        final ctx = _routeContext;
        if (ctx == null || !ctx.mounted || !isActive) return;

        await DoughTempCalculatorBottomSheet.runWhileOpen(
          ctx,
          controller,
          _runPhaseDoughTempSheet,
        );
      },
    );
  }

  Future<void> _runPhaseDoughTempSheet() async {
    TutorialGuideLog.d('_runPhaseDoughTempSheet: 시작');
    await _waitForKey(
      TutorialGuideKeys.doughTempTarget,
      label: 'doughTempTarget',
      required: true,
    );
    if (!isActive) return;

    await Future.delayed(const Duration(milliseconds: 350));
    await _waitForUiFrames(2);
    if (!isActive) return;

    await _showCoachMark(
      phase: 'dough_temp_sheet',
      useModalOverlay: true,
      targets: [
        _target(
          identify: 'dough_temp_target',
          key: TutorialGuideKeys.doughTempTarget,
          align: ContentAlign.bottom,
          title: '목표 반죽온도',
          body:
              '레시피 목표 반죽온도를 확인하고, 옷차림·마찰열을 조절해 권장 물 온도를 계산하세요.',
          paddingFocus: 8,
          radius: 10,
        ),
      ],
      onFinish: () async {
        TutorialGuideLog.d('_runPhaseDoughTempSheet onFinish');
      },
    );
  }

  Future<void> _runPhaseFermentationTimer() async {
    TutorialGuideLog.d('_runPhaseFermentationTimer: 시작');
    await _waitForKey(
      TutorialGuideKeys.fermentationTimer,
      label: 'fermentationTimer',
      required: true,
    );
    if (!isActive) return;

    await _scrollTargetIntoView(TutorialGuideKeys.fermentationTimer);
    await Future.delayed(const Duration(milliseconds: 350));
    await _waitForUiFrames(2);
    if (!isActive) return;

    await _showCoachMark(
      phase: 'fermentation_timer',
      useModalOverlay: true,
      targets: [
        _target(
          identify: 'fermentation_timer',
          key: TutorialGuideKeys.fermentationTimer,
          align: ContentAlign.top,
          title: '발효 타이머',
          body:
              '공정 타이머 첫 번째 항목을 확인하고, 재생 버튼으로 1차 발효 등 타이머를 시작할 수 있습니다.',
          paddingFocus: 8,
          radius: 10,
        ),
      ],
      onFinish: () async {
        TutorialGuideLog.d('_runPhaseFermentationTimer onFinish');
      },
    );
  }

  Future<void> _runPhaseNextStep() async {
    TutorialGuideLog.d('_runPhaseNextStep: 시작');
    await _waitForKey(
      TutorialGuideKeys.nextStep,
      label: 'nextStep',
      required: true,
    );
    if (!isActive) return;

    await _showCoachMark(
      phase: 'next_step',
      targets: [
        _target(
          identify: 'next_step',
          key: TutorialGuideKeys.nextStep,
          align: ContentAlign.top,
          title: '다음 공정',
          body: '다음 단계 버튼으로 공정을 이어갑니다. 체크리스트를 완료한 뒤 넘기세요.',
          shape: ShapeLightFocus.RRect,
          radius: 8,
        ),
      ],
      onFinish: () async {
        TutorialGuideLog.d('_runPhaseNextStep onFinish: 튜토리얼 완료');
        await _finishTutorial(popDetail: false);
      },
    );
  }

  Future<void> _showCoachMark({
    required String phase,
    required List<TargetFocus> targets,
    required FutureOr<void> Function() onFinish,
    bool useModalOverlay = false,
  }) async {
    _logContext('showCoachMark:$phase');
    final themeCtx = _routeContext;
    if (themeCtx == null || !themeCtx.mounted) {
      TutorialGuideLog.e(
        '_showCoachMark[$phase]: 중단 — route context 없음 '
        '(navigator=${Get.key.currentContext != null} get=${Get.context != null})',
      );
      await _finishTutorial(popDetail: false);
      return;
    }
    if (Get.key.currentState?.overlay == null && Get.context == null) {
      TutorialGuideLog.e('_showCoachMark[$phase]: Navigator overlay 없음');
      await _finishTutorial(popDetail: false);
      return;
    }
    if (!isActive) {
      TutorialGuideLog.w('_showCoachMark[$phase]: isActive=false — 중단');
      return;
    }

    for (final t in targets) {
      TutorialGuideLog.d('_showCoachMark[$phase]: target=${t.identify}');
    }
    _logTargetKeys(phase, targets);

    final scheme = Theme.of(themeCtx).colorScheme;
    final done = Completer<void>();

    TutorialGuideLog.d('_showCoachMark[$phase]: coachMark.show 호출');

    final coachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: scheme.primary,
      opacityShadow: 0.75,
      paddingFocus: 8,
      textSkip: '건너뛰기',
      onFinish: () {
        TutorialGuideLog.d('_showCoachMark[$phase]: onFinish 콜백');
        if (!done.isCompleted) done.complete();
      },
      onSkip: () {
        TutorialGuideLog.d('_showCoachMark[$phase]: onSkip');
        if (!done.isCompleted) done.complete();
        unawaited(_finishTutorial(popDetail: false));
        return true;
      },
    );

    try {
      _presentCoachMark(
        coachMark,
        phase,
        rootOverlay: !useModalOverlay,
        presentationContext: useModalOverlay
            ? _modalPresentationContext(targets)
            : null,
      );
    } catch (error, stackTrace) {
      TutorialGuideLog.e(
        '_showCoachMark[$phase]: show() 예외',
        error: error,
        stackTrace: stackTrace,
      );
      await _finishTutorial(popDetail: false);
      return;
    }

    try {
      await done.future.timeout(const Duration(minutes: 10));
    } on TimeoutException {
      TutorialGuideLog.e(
        '_showCoachMark[$phase]: 10분 타임아웃 (onFinish/onSkip 미호출)',
      );
      await _finishTutorial(popDetail: false);
      return;
    }
    if (!isActive) {
      TutorialGuideLog.d('_showCoachMark[$phase]: 스킵 후 onFinish 생략');
      return;
    }
    TutorialGuideLog.d('_showCoachMark[$phase]: onFinish 핸들러 실행');
    await onFinish();
  }

  void _logTargetKeys(String phase, List<TargetFocus> targets) {
    for (final t in targets) {
      final key = t.keyTarget;
      if (key == null) {
        TutorialGuideLog.w('_showCoachMark[$phase]: ${t.identify} keyTarget=null');
      } else {
        TutorialGuideLog.keyState('${t.identify}', key);
      }
    }
  }

  TargetFocus _target({
    required String identify,
    required GlobalKey key,
    required ContentAlign align,
    required String title,
    required String body,
    ShapeLightFocus shape = ShapeLightFocus.RRect,
    double radius = 8,
    double? paddingFocus,
  }) {
    return TargetFocus(
      identify: identify,
      keyTarget: key,
      shape: shape,
      radius: radius,
      paddingFocus: paddingFocus,
      contents: [
        TargetContent(
          align: align,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  body,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.35,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<bool> _waitForKey(
    GlobalKey key, {
    required String label,
    bool required = false,
  }) async {
    for (var i = 0; i < 30; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!isActive) return false;
      if (key.currentContext != null) {
        TutorialGuideLog.d('_waitForKey[$label]: OK (attempt=${i + 1})');
        TutorialGuideLog.keyState(label, key);
        return true;
      }
    }
    TutorialGuideLog.w('_waitForKey[$label]: 3초 타임아웃 — key 미연결');
    if (required) {
      await _finishTutorial(popDetail: false);
    }
    return false;
  }

  /// 재료 목록 바텀시트가 열려 있으면 닫는다 (타이머 단계 전 필수).
  Future<void> _closeIngredientsSheetIfOpen() async {
    if (Get.currentRoute != Routes.PROGRESS_DETAIL) return;

    final sheetContext = TutorialGuideKeys.ingredientsClose.currentContext ??
        TutorialGuideKeys.batchSlider.currentContext ??
        TutorialGuideKeys.firstIngredientCheck.currentContext;

    if (sheetContext != null && sheetContext.mounted) {
      TutorialGuideLog.d('_closeIngredientsSheetIfOpen: Navigator.pop (재료 시트)');
      Navigator.of(sheetContext).pop();
      await Future.delayed(const Duration(milliseconds: 250));
      await _waitForUiFrames(2);
      return;
    }

    TutorialGuideLog.d(
      '_closeIngredientsSheetIfOpen: 시트 context 없음 — '
      'batchSlider=${TutorialGuideKeys.batchSlider.currentContext != null}',
    );
    _popModalBottomSheetIfOpen();
  }

  /// 바텀시트만 닫는다. 상세(/progress-detail) 라우트는 pop하지 않는다.
  void _popModalIfOpen() {
    _popModalBottomSheetIfOpen();
  }

  void _popModalBottomSheetIfOpen() {
    if (Get.currentRoute != Routes.PROGRESS_DETAIL) return;

    final nav = Get.key.currentState;
    if (nav == null || !nav.canPop()) return;

    final overlayContext = nav.overlay?.context;
    if (overlayContext == null) return;

    final topRoute = ModalRoute.of(overlayContext);
    final isBottomSheet = topRoute is ModalBottomSheetRoute ||
        (topRoute is ModalRoute && !topRoute.opaque);

    if (!isBottomSheet) {
      TutorialGuideLog.d('_popModalBottomSheetIfOpen: 열린 바텀시트 없음 — skip');
      return;
    }

    TutorialGuideLog.d('_popModalBottomSheetIfOpen: 바텀시트 pop');
    nav.pop();
  }

  Future<void> _cleanupDemoSession({required bool popDetail}) async {
    final repo = Get.find<ProgressSessionRepository>();
    final existing =
        await repo.findInProgressByRecipeId(TutorialGuideKeys.demoRecipeId);

    if (existing != null) {
      TutorialGuideLog.d(
        '_cleanupDemoSession: repo inProgress sessionId=${existing.sessionId}',
      );
      final scheduleService = Get.find<TimerScheduleService>();
      final timers =
          await scheduleService.activeTimersForSession(existing.sessionId);
      for (final timer in timers) {
        await scheduleService.cancelTimer(timer.timerId);
      }

      final now = DateTime.now();
      final updated = existing.copyWith(
        status: ProgressSessionStatus.abandoned,
        updatedAt: now,
      );
      await repo.upsert(updated);
    }

    if (Get.isRegistered<ProgressDetailController>()) {
      final controller = Get.find<ProgressDetailController>();
      if (controller.recipeId == TutorialGuideKeys.demoRecipeId) {
        if (controller.session.value?.status ==
            ProgressSessionStatus.inProgress) {
          controller.session.value = null;
          TutorialGuideLog.d('_cleanupDemoSession: controller.session=null');
        }
      }
    }

    if (popDetail && Get.currentRoute == Routes.PROGRESS_DETAIL) {
      Get.back();
    }
  }

  Future<void> _finishTutorial({required bool popDetail}) async {
    TutorialGuideLog.d('_finishTutorial: popDetail=$popDetail');
    _popModalIfOpen();
    await _cleanupDemoSession(popDetail: popDetail);
    isActive = false;
    _detailPhasesStarted = false;
  }
}
