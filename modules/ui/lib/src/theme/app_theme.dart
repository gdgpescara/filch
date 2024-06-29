import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'extended_color.dart';
part 'text_theme.dart';

final _seedColor = _googleYellow.seed;

ThemeData buildTheme(Brightness brightness) {
  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: _seedColor, brightness: brightness),
    extensions: const [_extendedColor],
    inputDecorationTheme: _inputDecorationTheme,
  );

  return theme.copyWith(
    appBarTheme: _appBarTheme(theme),
    textTheme: _textTheme(theme.textTheme),
  );
}

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  Brightness get brightness => theme.brightness;
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  ExtendedColor get appColors => theme.extension<ExtendedColor>()!;
}

final _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  isDense: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
);

AppBarTheme _appBarTheme(ThemeData theme) => AppBarTheme(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.openSans(fontSize: theme.textTheme.titleLarge?.fontSize),
    );
