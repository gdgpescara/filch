import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'suggestion_item_widget.dart';

class QuestSuggestionsWidget extends StatelessWidget {
  const QuestSuggestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      style: AppCardStyle.caption,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                color: context.colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: Spacing.s),
              Expanded(
                child: Text(
                  t.quests.active_quest.suggestions_title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.m),
          ..._buildSuggestionsList(context),
        ],
      ),
    );
  }

  List<Widget> _buildSuggestionsList(BuildContext context) {
    final suggestions = [
      (Icons.people_outline_rounded, t.quests.active_quest.suggestion_explore),
      (Icons.schedule_rounded, t.quests.active_quest.suggestion_schedule),
      (Icons.leaderboard_rounded, t.quests.active_quest.suggestion_ranking),
    ];

    return suggestions
        .map(
          (suggestion) => SuggestionItemWidget(
            icon: suggestion.$1,
            text: suggestion.$2,
          ),
        )
        .toList();
  }
}
