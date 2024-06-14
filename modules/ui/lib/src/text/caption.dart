import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Caption extends StatelessWidget {
  const Caption({super.key, required this.text, this.textThemeType = TextThemeType.normal});

  final String text;
  final TextThemeType textThemeType;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).getTextTheme(textThemeType).bodySmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
