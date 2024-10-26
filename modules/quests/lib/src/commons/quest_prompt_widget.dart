import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuestPromptWidget extends StatelessWidget {
  const QuestPromptWidget(this.prompt, {super.key});

  final Map<String, String> prompt;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: context.theme.colorScheme.primary,
              width: 4,
            ),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          prompt[LocaleSettings.currentLocale.languageCode] ?? '',
          style: context.getTextTheme(TextThemeType.monospace).bodyMedium,
        ),
      ),
    );
  }
}
