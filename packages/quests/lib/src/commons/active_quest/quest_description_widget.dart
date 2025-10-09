import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../models/active_quest.dart';

class QuestDescriptionWidget extends StatelessWidget {
  const QuestDescriptionWidget({super.key, required this.activeQuest});

  final ActiveQuest activeQuest;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.caption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_rounded,
                color: context.colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: Spacing.s),
              Text(
                t.quests.active_quest.actors.description.label,
                style: context.getTextTheme(TextThemeType.monospace).titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.m),
          Text(
            activeQuest.quest.description[LocaleSettings.currentLocale.languageCode] ?? '',
            style: context.textTheme.bodyLarge?.copyWith(
              height: 1.5,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
