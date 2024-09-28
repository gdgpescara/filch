import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class UserPointsValue extends StatelessWidget {
  const UserPointsValue({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}
