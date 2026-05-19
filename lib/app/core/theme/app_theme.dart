import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'app_seed_colors.dart';

abstract final class AppTheme {
  static ColorScheme colorSchemeForSeed(Color seed, Brightness brightness) {
    return SeedColorScheme.fromSeeds(
      brightness: brightness,
      primaryKey: seed,
      primary: seed,
      tones: FlexTones.material(brightness),
    );
  }

  static ThemeData fromSeed(Color seed, Brightness brightness) {
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
