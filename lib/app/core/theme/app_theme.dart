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

  /// 강조 라벨·버튼 등 — 배경 위 primary 대비가 낮으면 tertiary·onSurface 순으로 대체.
  static Color readableAccentColor(
    ColorScheme scheme, {
    Color? onBackground,
  }) {
    final background = onBackground ?? scheme.surface;
    for (final candidate in [scheme.primary, scheme.tertiary]) {
      if (_contrastRatio(candidate, background) >= 3.0) {
        return candidate;
      }
    }
    return scheme.onSurface;
  }

  /// [readableAccentColor]를 primary/onPrimary에 반영한 ColorScheme.
  static ColorScheme withReadableAccent(
    ColorScheme scheme, {
    required Color scaffoldBackground,
  }) {
    final accent = readableAccentColor(
      scheme,
      onBackground: scaffoldBackground,
    );
    if (accent == scheme.primary) {
      return scheme;
    }
    return scheme.copyWith(
      primary: accent,
      onPrimary: onReadableAccent(accent, scheme),
    );
  }

  static Color onReadableAccent(Color accent, ColorScheme scheme) {
    if (accent == scheme.tertiary) {
      return scheme.onTertiary;
    }
    if (accent == scheme.onSurface) {
      return scheme.brightness == Brightness.dark
          ? scheme.surface
          : Colors.white;
    }
    return scheme.onPrimary;
  }

  static double _contrastRatio(Color a, Color b) {
    final la = a.computeLuminance();
    final lb = b.computeLuminance();
    final lighter = la > lb ? la : lb;
    final darker = la > lb ? lb : la;
    return (lighter + 0.05) / (darker + 0.05);
  }

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
    final rawScheme = colorSchemeForSeed(seed, brightness);
    final isLight = brightness == Brightness.light;

    final base = isLight
        ? FlexThemeData.light(
            colorScheme: rawScheme,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 7,
            scaffoldBackground: Colors.white,
          )
        : FlexThemeData.dark(
            colorScheme: rawScheme,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 7,
          );

    final scaffoldBackground =
        isLight ? Colors.white : base.scaffoldBackgroundColor;
    var scheme = rawScheme;
    if (isLight) {
      scheme = scheme.copyWith(surface: Colors.white);
    }
    scheme = withReadableAccent(
      scheme,
      scaffoldBackground: scaffoldBackground,
    );

    return base.copyWith(
      scaffoldBackgroundColor: scaffoldBackground,
      colorScheme: scheme,
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
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.onSurfaceVariant,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: scheme.primary,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          color: scheme.onSurfaceVariant,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.onPrimary;
            }
            return scheme.onSurfaceVariant;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return scheme.primary;
            }
            return Colors.transparent;
          }),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: scheme.primary,
        thumbColor: scheme.primary,
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
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return null;
        }),
      ),
      iconTheme: IconThemeData(color: scheme.onSurface),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
    );
  }

  static ThemeData light([Color? seed]) =>
      fromSeed(seed ?? AppSeedColors.defaultSeed, Brightness.light);

  static ThemeData dark([Color? seed]) =>
      fromSeed(seed ?? AppSeedColors.defaultSeed, Brightness.dark);
}
