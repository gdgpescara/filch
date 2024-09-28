import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';

import '../current_quest/state/current_quest_cubit.dart';

class NoQuestAssignedWidget extends StatelessWidget {
  const NoQuestAssignedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            t.quests.active_quest.no_quest_assigned,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: context.read<CurrentQuestCubit>().searchForQuest,
          child: Text(t.quests.active_quest.search_button),
        ),
      ],
    );
  }
}
