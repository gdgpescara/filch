import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../_shared/widgets/app_card.dart';
import '../../../models/active_quest.dart';
import '../../../models/quest_types_enum.dart';

class QuestDescriptionWidget extends StatelessWidget {
  const QuestDescriptionWidget({super.key, required this.activeQuest});

  final ActiveQuest activeQuest;

  String get _labelByType => switch(activeQuest.quest.type) {
        QuestTypeEnum.actor => t.active_quest.actors.description.label,
        QuestTypeEnum.quiz => t.active_quest.quiz.question.label,
        QuestTypeEnum.social => t.active_quest.social.description.label,
      };

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _labelByType,
            style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10, width: double.infinity),
          Text(
            activeQuest.quest.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
