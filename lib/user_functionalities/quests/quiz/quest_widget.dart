import 'package:flutter/material.dart';

import '../actor/actor_quest_widget.dart';
import '../commons/time_remaining.dart';
import '../models/active_quest.dart';
import '../models/quest_types_enum.dart';
import '../social/social_quest_widget.dart';
import 'quiz_quest_widget.dart';

class QuestWidget extends StatelessWidget {
  const QuestWidget(this.activeQuest, {super.key});

  final ActiveQuest activeQuest;

  Widget get _specificQuestWidget => switch (activeQuest.quest.type) {
        QuestTypeEnum.actor => const ActorQuestWidget(),
        QuestTypeEnum.quiz => const QuizQuestWidget(),
        QuestTypeEnum.social => const SocialQuestWidget(),
      };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimeRemaining(activeQuest),
              const SizedBox(height: 20),
              _specificQuestWidget,
            ],
          ),
        ),
      ),
    );
  }
}
