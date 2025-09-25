import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ui.dart';

part 'app_bar_theme.dart';
part 'navigation_bar_theme.dart';
part 'bottom_sheet_theme.dart';
part 'button_theme.dart';
part 'extended_color.dart';
part 'input_decorator_theme.dart';
part 'text_theme.dart';

const appColors = _extendedColor;
const _backgroundSeedColor = Color(0xFF060404);
const _primaryColor = Color(0xFF3089FF);
const _surfaceColor = Color(0xFFFCFBFF);
const _onSurfaceColor = Color(0xFF060404);

ColorScheme _colorScheme(Brightness brightness, Color? seedColor) =>
    ColorScheme.fromSeed(
      seedColor: seedColor ?? _primaryColor,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    ).copyWith(
      surface: brightness == Brightness.dark ? _backgroundSeedColor : _surfaceColor,
      onSurface: brightness == Brightness.dark ? _surfaceColor : _onSurfaceColor,
      surfaceBright: brightness == Brightness.dark ? const Color(0xFF1A1A1A) : _surfaceColor,
      primary: _primaryColor,
      onPrimary: _surfaceColor,
      primaryContainer: brightness == Brightness.dark ? const Color(0xFF1E5BA8) : const Color(0xFF5BA2FF),
      onPrimaryContainer: brightness == Brightness.dark ? _surfaceColor : _onSurfaceColor,
      secondary: _primaryColor.withValues(alpha: 0.8),
      onSecondary: _surfaceColor,
      secondaryContainer: _primaryColor.withValues(alpha: 0.2),
      onSecondaryContainer: _onSurfaceColor,
      tertiary: _primaryColor.withValues(alpha: 0.6),
      onTertiary: _surfaceColor,
      tertiaryContainer: _primaryColor.withValues(alpha: 0.1),
      onTertiaryContainer: _onSurfaceColor,
      error: _error._dark.color,
      onError: _error._dark.onColor,
      errorContainer: _error._dark.colorContainer,
      onErrorContainer: _error._dark.onColorContainer,
    );

ThemeData buildTheme(Brightness brightness, {Color? seedColor}) {
  final colorScheme = _colorScheme(brightness, seedColor);
  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    inputDecorationTheme: _inputDecorationTheme(colorScheme),
    elevatedButtonTheme: _elevatedButtonThemeData(colorScheme),
    textButtonTheme: _textButtonThemeData(colorScheme),
    outlinedButtonTheme: _outlinedButtonThemeData(colorScheme),
    filledButtonTheme: _filledButtonThemeData(colorScheme),
    scaffoldBackgroundColor: Colors.transparent,
    bottomSheetTheme: _bottomSheetTheme(colorScheme),
    navigationBarTheme: _navigationBarTheme(colorScheme),
  );

  return theme.copyWith(appBarTheme: _appBarTheme(theme), textTheme: _textTheme(theme.textTheme));
}

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  Brightness get brightness => theme.brightness;

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme getTextTheme([TextThemeType type = TextThemeType.normal]) => theme.getTextTheme(type);
}
