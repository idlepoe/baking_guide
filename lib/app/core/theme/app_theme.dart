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

  static ThemeData fromSeed(
    Color seed,
    Brightness brightness, {
    double fontSizeFactor = 1.0,
  }) {
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

    final textTheme = _scaleTextTheme(base.textTheme, fontSizeFactor);
    final primaryTextTheme =
        _scaleTextTheme(base.primaryTextTheme, fontSizeFactor);

    return base.copyWith(
      scaffoldBackgroundColor:
          isLight ? Colors.white : base.scaffoldBackgroundColor,
      colorScheme: isLight ? scheme.copyWith(surface: Colors.white) : scheme,
      textTheme: textTheme,
      primaryTextTheme: primaryTextTheme,
      appBarTheme: base.appBarTheme.copyWith(
        titleTextStyle: _scaleTextStyle(
          base.appBarTheme.titleTextStyle,
          fontSizeFactor,
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

  static TextTheme _scaleTextTheme(TextTheme theme, double factor) {
    if (factor == 1.0) return theme;

    return TextTheme(
      displayLarge: _scaleTextStyle(theme.displayLarge, factor),
      displayMedium: _scaleTextStyle(theme.displayMedium, factor),
      displaySmall: _scaleTextStyle(theme.displaySmall, factor),
      headlineLarge: _scaleTextStyle(theme.headlineLarge, factor),
      headlineMedium: _scaleTextStyle(theme.headlineMedium, factor),
      headlineSmall: _scaleTextStyle(theme.headlineSmall, factor),
      titleLarge: _scaleTextStyle(theme.titleLarge, factor),
      titleMedium: _scaleTextStyle(theme.titleMedium, factor),
      titleSmall: _scaleTextStyle(theme.titleSmall, factor),
      bodyLarge: _scaleTextStyle(theme.bodyLarge, factor),
      bodyMedium: _scaleTextStyle(theme.bodyMedium, factor),
      bodySmall: _scaleTextStyle(theme.bodySmall, factor),
      labelLarge: _scaleTextStyle(theme.labelLarge, factor),
      labelMedium: _scaleTextStyle(theme.labelMedium, factor),
      labelSmall: _scaleTextStyle(theme.labelSmall, factor),
    );
  }

  static TextStyle? _scaleTextStyle(TextStyle? style, double factor) {
    if (style == null || factor == 1.0) return style;

    final fontSize = style.fontSize;
    if (fontSize == null) return style;

    return style.copyWith(fontSize: fontSize * factor);
  }
}
