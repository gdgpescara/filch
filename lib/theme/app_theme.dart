import 'package:flutter/material.dart';

part 'color_schemes.dart';

part 'custom_color.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  extensions: [lightCustomColors],
  inputDecorationTheme: _inputDecorationTheme,
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  extensions: [darkCustomColors],
  inputDecorationTheme: _inputDecorationTheme,
);

final _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  isDense: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
);
