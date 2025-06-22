import 'package:flutter/material.dart';

import '../../ui.dart';

class Paragraph extends StatelessWidget {
  const Paragraph({super.key, required this.text, this.textThemeType = TextThemeType.normal});

  final String text;
  final TextThemeType textThemeType;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.getTextTheme(textThemeType).bodyMedium);
  }
}
