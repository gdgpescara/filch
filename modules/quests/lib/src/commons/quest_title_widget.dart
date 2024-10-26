import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';


class QuestTitleWidget extends StatelessWidget {
  const QuestTitleWidget(this.title, {super.key});

  final Map<String, String> title;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title[LocaleSettings.currentLocale.languageCode] ?? '',
          style: context.getTextTheme(TextThemeType.themeSpecific).headlineSmall,
        ),
      ),
    );
  }
}
