import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_functionalities/widgets/app_card.dart';
import '../../../i18n/strings.g.dart';
import '../../../utils/extensions/duration_extension.dart';
import '../models/active_quest.dart';

class TimeRemaining extends StatelessWidget {
  const TimeRemaining(this.activeQuest, {super.key});

  final ActiveQuest activeQuest;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Text(
        activeQuest.remainingTime.format(
          hoursFormatter: (n) => t.active_quest.time_remaining.hours(n: n),
          minutesFormatter: (n) => t.active_quest.time_remaining.minutes(n: n),
          secondsFormatter: (n) => t.active_quest.time_remaining.seconds(n: n),
        ),
        style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold, fontSize: 18),
        textAlign: TextAlign.right,
      ),
    );
  }
}
