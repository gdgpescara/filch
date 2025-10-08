import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ui.dart';
import 'tappable_area_clipper.dart';

part 'app_bar_theme.dart';
part 'navigation_bar_theme.dart';
part 'bottom_sheet_theme.dart';
part 'button_theme.dart';
part 'extended_color.dart';
part 'input_decorator_theme.dart';
part 'tab_bar_theme.dart';
part 'text_theme.dart';

const appColors = _extendedColor;
const _primaryColor = Color(0xFF060404);
const _secondaryColor = Color(0xFF3089FF); // Blue secondary color
const _surfaceColor = Color(0xFFDDDDDD);
const _onSurfaceColor = Color(0xFF1A1A1A);

ColorScheme _colorScheme(Brightness brightness, Color? seedColor) =>
    ColorScheme.fromSeed(
      seedColor: seedColor ?? _primaryColor,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    ).copyWith(
      surface: _surfaceColor,
      onSurface: _onSurfaceColor,
      surfaceBright: _surfaceColor,
      primary: _primaryColor,
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: _primaryColor.withValues(alpha: 0.05),
      onPrimaryContainer: brightness == Brightness.dark ? const Color(0xFFFFFFFF) : const Color(0xFF2D0707),
      secondary: _secondaryColor,
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: _secondaryColor.withValues(alpha: 0.25),
      onSecondaryContainer: _onSurfaceColor,
      tertiary: const Color(0xFF6B7280),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFFF3F4F6),
      onTertiaryContainer: const Color(0xFF374151),
      error: brightness == Brightness.dark ? _error._dark.color : _error._light.color,
      onError: brightness == Brightness.dark ? _error._dark.onColor : _error._light.onColor,
      errorContainer: brightness == Brightness.dark ? _error._dark.colorContainer : _error._light.colorContainer,
      onErrorContainer: brightness == Brightness.dark ? _error._dark.onColorContainer : _error._light.onColorContainer,
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
    scaffoldBackgroundColor: _surfaceColor,
    bottomSheetTheme: _bottomSheetTheme(colorScheme),
    navigationBarTheme: _navigationBarTheme(colorScheme),
    tabBarTheme: _tabBarTheme(colorScheme),
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
