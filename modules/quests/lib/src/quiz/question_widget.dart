import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../models/active_quest.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.activeQuest});

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
            t.quests.active_quest.quiz.question.label,
            style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10, width: double.infinity),
          Text(
            activeQuest.quest.question?[LocaleSettings.currentLocale.languageCode] ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
