import 'package:flutter/material.dart';

part 'color_schemes.dart';

part 'custom_color.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  extensions: [lightCustomColors],
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  extensions: [darkCustomColors],
);
