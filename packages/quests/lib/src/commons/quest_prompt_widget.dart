import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuestPromptWidget extends StatelessWidget {
  const QuestPromptWidget(this.prompt, {super.key});

  final Map<String, String> prompt;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.caption,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          prompt[LocaleSettings.currentLocale.languageCode] ?? '',
          style: context.getTextTheme(TextThemeType.monospace).bodyMedium,
        ),
      ),
    );
  }
}
