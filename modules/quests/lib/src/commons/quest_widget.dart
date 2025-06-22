import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../actor/actor_quest_widget.dart';
import '../community/community_quest_widget.dart';
import '../models/active_quest.dart';
import '../models/quest_types_enum.dart';
import '../quiz/quiz_quest_widget.dart';
import '../social/social_quest_widget.dart';
import 'give_up_button.dart';
import 'quest_title_widget.dart';
import 'time_remaining.dart';

class QuestWidget extends StatelessWidget {
  const QuestWidget(this.activeQuest, {super.key});

  final ActiveQuest activeQuest;

  Widget get _specificQuestWidget => switch (activeQuest.quest.type) {
    QuestTypeEnum.actor => const ActorQuestWidget(),
    QuestTypeEnum.quiz => const QuizQuestWidget(),
    QuestTypeEnum.social => const SocialQuestWidget(),
    QuestTypeEnum.community => const CommunityQuestWidget(),
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: Spacing.l, horizontal: Spacing.s),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (activeQuest.quest.title != null) QuestTitleWidget(activeQuest.quest.title!),
              TimeRemaining(activeQuest),
              _specificQuestWidget,
              const SizedBox(height: Spacing.l),
              const GiveUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}
