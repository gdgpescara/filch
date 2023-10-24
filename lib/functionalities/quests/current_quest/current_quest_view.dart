import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection/dependency_injection.dart';
import '../../_shared/widgets/loader_animation.dart';
import 'state/current_quest_cubit.dart';
import 'widgets/no_quest_assigned_widget.dart';
import 'widgets/quest_widget.dart';

class CurrentQuestView extends StatelessWidget {
  const CurrentQuestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentQuestCubit>(
      create: (_) => injector()..loadCurrentQuest(),
      child: BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
        builder: (context, state) {
          return switch (state) {
            CurrentQuestLoading() => const Center(child: LoaderAnimation()),
            CurrentQuestLoaded(activeQuest: final activeQuest) => QuestWidget(activeQuest),
            _ => const NoQuestAssignedWidget(),
          };
        },
      ),
    );
  }
}
