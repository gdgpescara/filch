import 'package:flutter/material.dart';

import '../../models/active_quest.dart';
import '../../models/quest_types_enum.dart';
import 'actor/quest_qr_code_widget.dart';
import 'commons/quest_description_widget.dart';
import 'commons/time_remaining.dart';
import 'quiz/quiz_quest_widget.dart';

class QuestWidget extends StatelessWidget {
  const QuestWidget(this.activeQuest, {super.key});

  final ActiveQuest activeQuest;

  Widget get _specificQuestWidget => switch (activeQuest.quest.type) {
        QuestTypeEnum.actor => const QuestQrCodeWidget(),
        QuestTypeEnum.quiz => const QuizQuestWidget(),
        QuestTypeEnum.social => const SizedBox(),
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
              QuestDescriptionWidget(activeQuest: activeQuest),
              const SizedBox(height: 20),
              _specificQuestWidget,
            ],
          ),
        ),
      ),
    );
  }
}
