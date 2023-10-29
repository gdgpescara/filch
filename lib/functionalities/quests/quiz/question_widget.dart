import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../i18n/strings.g.dart';
import '../../_shared/widgets/app_card.dart';
import '../models/active_quest.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.activeQuest});

  final ActiveQuest activeQuest;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.active_quest.quiz.question.label,
            style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10, width: double.infinity),
          Text(
            activeQuest.quest.question ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
