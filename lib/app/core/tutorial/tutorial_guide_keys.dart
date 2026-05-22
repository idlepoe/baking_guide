import 'package:flutter/material.dart';

/// 코치마크 튜토리얼용 [GlobalKey] 모음.
abstract final class TutorialGuideKeys {
  static const demoRecipeId = 'sweet_roll';

  /// 4단계(1차 발효) — steps 인덱스 3
  static const demoFermentationStepIndex = 3;

  /// 1단계(반죽온도 계산기) — steps 인덱스 0
  static const demoDoughTempStepIndex = 0;

  static final recipeCard = GlobalKey();
  static final recipeBookmark = GlobalKey();
  static final practiceStart = GlobalKey();
  static final batchSlider = GlobalKey();
  static final firstIngredientCheck = GlobalKey();
  /// 재료 시트 하단 「닫기」 버튼
  static final ingredientsClose = GlobalKey();
  static final timerFab = GlobalKey();
  /// 공정 타이머 목록 첫 번째 ListTile 행
  static final fermentationTimer = GlobalKey();
  static final doughTempFab = GlobalKey();
  static final doughTempTarget = GlobalKey();
  static final nextStep = GlobalKey();
}
