import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class TShirtWidget extends StatelessWidget {
  const TShirtWidget(this.message, {super.key, required this.borderColor});

  final String message;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.caption,
      borderColor: borderColor,
      child: SizedBox(
        width: double.infinity,
        child: Text(message, style: context.getTextTheme(TextThemeType.monospace).bodyMedium),
      ),
    );
  }
}
