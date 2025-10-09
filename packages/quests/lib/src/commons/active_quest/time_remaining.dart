import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../current_quest/state/current_quest_cubit.dart';
import '../../models/active_quest.dart';

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

    final totalSeconds = widget.activeQuest.quest.executionTime.inSeconds;
    final remainingSeconds = widget.activeQuest.remainingTime.inSeconds;
    final progress = remainingSeconds / totalSeconds;
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(RadiusSize.m),
        border: Border.all(color: context.colorScheme.secondary),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.activeQuest.remainingTime.format(
              hoursFormatter: (n) => t.quests.active_quest.time_remaining.hours(n: n),
              minutesFormatter: (n) => t.quests.active_quest.time_remaining.minutes(n: n),
              secondsFormatter: (n) => t.quests.active_quest.time_remaining.seconds(n: n),
            ),
            style: context
                .getTextTheme(TextThemeType.monospace)
                .bodyLarge
                ?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSecondaryContainer,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.s),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: context.colorScheme.secondary.withValues(alpha: 0.5),
            valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.onSecondaryContainer),
          ),
        ],
      ),
    );
  }
}
