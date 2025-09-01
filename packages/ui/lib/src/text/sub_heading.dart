import 'package:flutter/material.dart';

import '../../ui.dart';

class SubHeading extends StatelessWidget {
  const SubHeading({super.key, required this.text, this.textThemeType = TextThemeType.monospace});

  final String text;
  final TextThemeType textThemeType;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.getTextTheme(textThemeType).titleMedium?.copyWith(fontWeight: FontWeight.w600));
  }
}
