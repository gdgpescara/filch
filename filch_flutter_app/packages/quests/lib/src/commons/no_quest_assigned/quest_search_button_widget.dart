import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../current_quest/state/current_quest_cubit.dart';

class QuestSearchButtonWidget extends StatelessWidget {
  const QuestSearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: context.read<CurrentQuestCubit>().searchForQuest,
        icon: const Icon(Icons.search_rounded),
        label: Text(t.quests.active_quest.search_button),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.m,
            horizontal: Spacing.l,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusSize.m),
          ),
        ),
      ),
    );
  }
}
