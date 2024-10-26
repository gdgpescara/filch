import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../models/active_quest.dart';

class QuestDescriptionWidget extends StatelessWidget {
  const QuestDescriptionWidget({super.key, required this.activeQuest});

  final ActiveQuest activeQuest;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.normal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.quests.active_quest.actors.description.label,
            style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10, width: double.infinity),
          Text(
            activeQuest.quest.description[LocaleSettings.currentLocale.languageCode] ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
