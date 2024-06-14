import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'color_schemes.dart';
part 'custom_color.dart';
part 'text_theme.dart';

ThemeData lightTheme() {
  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    extensions: [lightCustomColors],
    inputDecorationTheme: _inputDecorationTheme,
  );
  return theme.copyWith(
    appBarTheme: _appBarTheme(theme),
    textTheme: _textTheme(theme.textTheme),
  );
}

ThemeData darkTheme() {
  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    extensions: [darkCustomColors],
    inputDecorationTheme: _inputDecorationTheme,
  );

  return theme.copyWith(
    appBarTheme: _appBarTheme(theme),
    textTheme: _textTheme(theme.textTheme),
  );
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
