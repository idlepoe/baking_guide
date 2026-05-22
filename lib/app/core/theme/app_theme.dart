import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'app_seed_colors.dart';

abstract final class AppTheme {
  /// 레시피·진행 목록 카드 배경 — 다크 모드에서 스캐폴드보다 한 단계 밝게.
  static Color listItemCardBackground(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark
          ? scheme.surfaceContainer
          : scheme.surfaceContainerLow;

  /// 모달 바텀시트 배경 (다크: 목록 카드와 동일).
  static Color modalBottomSheetBackground(ColorScheme scheme) =>
      scheme.brightness == Brightness.dark
          ? scheme.surfaceContainer
          : scheme.surface;

  static ColorScheme colorSchemeForSeed(Color seed, Brightness brightness) {
    return SeedColorScheme.fromSeeds(
      brightness: brightness,
      primaryKey: seed,
      primary: seed,
      tones: FlexTones.material(brightness),
    );
  }

  static ThemeData fromSeed(
    Color seed,
    Brightness brightness,
  ) {
    final scheme = colorSchemeForSeed(seed, brightness);
    final isLight = brightness == Brightness.light;

    final base = isLight
        ? FlexThemeData.light(
            colorScheme: scheme,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 7,
            scaffoldBackground: Colors.white,
          )
        : FlexThemeData.dark(
            colorScheme: scheme,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 7,
          );

    return base.copyWith(
      scaffoldBackgroundColor:
          isLight ? Colors.white : base.scaffoldBackgroundColor,
      colorScheme: isLight ? scheme.copyWith(surface: Colors.white) : scheme,
      cardTheme: CardThemeData(
        color: listItemCardBackground(scheme),
        elevation: isLight ? 1 : 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: isLight ? null : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isLight
              ? BorderSide.none
              : BorderSide(
                  color: scheme.outlineVariant.withValues(alpha: 0.65),
                ),
        ),
        margin: EdgeInsets.zero,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: modalBottomSheetBackground(scheme),
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.surfaceContainerHighest,
          disabledForegroundColor: scheme.onSurfaceVariant,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.onPrimary;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return null;
        }),
      ),
    );
  }

  static ThemeData light([Color? seed]) =>
      fromSeed(seed ?? AppSeedColors.defaultSeed, Brightness.light);

  static ThemeData dark([Color? seed]) =>
      fromSeed(seed ?? AppSeedColors.defaultSeed, Brightness.dark);

}
