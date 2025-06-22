import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../current_quest/state/current_quest_cubit.dart';
import '../models/active_quest.dart';

class TimeRemaining extends StatefulWidget {
  const TimeRemaining(this.activeQuest, {super.key});

  final ActiveQuest activeQuest;

  @override
  State<TimeRemaining> createState() => _TimeRemainingState();
}

class _TimeRemainingState extends State<TimeRemaining> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.activeQuest.remainingTime.inSeconds <= 0) {
      _timer?.cancel();
      context.read<CurrentQuestCubit>().timeExpired();
    }
    return AppCard(
      style: AppCardStyle.normal,
      padding: EdgeInsets.zero,
      child: Text(
        widget.activeQuest.remainingTime.format(
          hoursFormatter: (n) => t.quests.active_quest.time_remaining.hours(n: n),
          minutesFormatter: (n) => t.quests.active_quest.time_remaining.minutes(n: n),
          secondsFormatter: (n) => t.quests.active_quest.time_remaining.seconds(n: n),
        ),
        style: context
            .getTextTheme(TextThemeType.monospace)
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
        textAlign: TextAlign.right,
      ),
    );
  }
}
