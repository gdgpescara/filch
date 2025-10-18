import 'package:flutter/material.dart';

import '../../ui.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.text, this.textThemeType = TextThemeType.themeSpecific});

  final String text;
  final TextThemeType textThemeType;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.getTextTheme(textThemeType).titleLarge?.copyWith(fontWeight: FontWeight.w900));
  }
}
