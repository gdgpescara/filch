import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ui.dart';

part 'app_bar_theme.dart';
part 'button_theme.dart';
part 'extended_color.dart';
part 'input_decorator_theme.dart';
part 'text_theme.dart';
part 'bottom_sheet_theme.dart';

const appColors = _extendedColor;
const _backgroundSeedColor = Color(0xFF0A0D36);
const _pinkColor = Color(0xFFE71F80);
const _orangeColor = Color(0xFFF3932E);
const _lightBlueColor = Color(0xFF3ABBED);

ColorScheme _colorScheme(Brightness brightness, Color? seedColor) =>
    ColorScheme.fromSeed(
      seedColor: seedColor ?? _pinkColor,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    ).copyWith(
      surface: _backgroundSeedColor,
      onSurface: const Color(0xFFFFFFFF),
      surfaceBright: const Color(0xFF1A1B2A),
      primary: _pinkColor,
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFAC2567),
      onPrimaryContainer: const Color(0xFFFFFFFF),
      secondary: _orangeColor,
      onSecondary: const Color(0xFF1A1B2A),
      secondaryContainer: const Color(0xFFE5A23D),
      onSecondaryContainer: const Color(0xFF1A1B2A),
      tertiary: _lightBlueColor,
      onTertiary: const Color(0xFF1A1B2A),
      tertiaryContainer: const Color(0xFF2E8BC0),
      onTertiaryContainer: const Color(0xFF1A1B2A),
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
    scaffoldBackgroundColor: Colors.transparent,
    bottomSheetTheme: _bottomSheetTheme(colorScheme),
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
