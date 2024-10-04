import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/ui.dart';

import '../commons/no_quest_assigned_widget.dart';
import '../commons/quest_request_closed_widget.dart';
import '../quiz/quest_widget.dart';
import 'state/current_quest_cubit.dart';

class CurrentQuestPage extends StatelessWidget {
  const CurrentQuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentQuestCubit>(
      create: (_) => GetIt.I()..loadCurrentQuest(),
      child: BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
        builder: (context, state) {
          return switch (state) {
            CurrentQuestLoading() => const Center(child: LoaderAnimation()),
            CurrentQuestLoaded(activeQuest: final activeQuest) => QuestWidget(activeQuest),
            QuestRequestClosed() => const QuestRequestClosedWidget(),
            _ => const NoQuestAssignedWidget(),
          };
        },
      ),
    );
  }
}
