import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuestTitleWidget extends StatelessWidget {
  const QuestTitleWidget(this.title, {super.key});

  final Map<String, String> title;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.caption,
      child: Text(
        title[LocaleSettings.currentLocale.languageCode] ?? '',
        style: context
            .getTextTheme()
            .headlineSmall
            ?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSecondaryContainer,
            ),
      ),
    );
  }
}
