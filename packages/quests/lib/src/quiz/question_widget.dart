import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../models/active_quest.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.activeQuest});

  final ActiveQuest activeQuest;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(RadiusSize.m),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.quiz_rounded,
                color: context.colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: Spacing.s),
              Text(
                t.quests.active_quest.quiz.question.label,
                style: context
                    .getTextTheme(TextThemeType.monospace)
                    .titleSmall
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.secondary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.m),
          Container(
            padding: const EdgeInsets.all(Spacing.m),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(RadiusSize.m),
              border: Border.all(
                color: context.colorScheme.secondary.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              activeQuest.quest.question?[LocaleSettings.currentLocale.languageCode] ?? '',
              style: context.textTheme.bodyLarge?.copyWith(
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onSurface,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
