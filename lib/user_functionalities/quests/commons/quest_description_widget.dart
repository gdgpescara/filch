import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../common_functionalities/widgets/app_card.dart';
import '../models/active_quest.dart';

class QuestDescriptionWidget extends StatelessWidget {
  const QuestDescriptionWidget({super.key, required this.activeQuest});

  final ActiveQuest activeQuest;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.active_quest.actors.description.label,
            style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
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
