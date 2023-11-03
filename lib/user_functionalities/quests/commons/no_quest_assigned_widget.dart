import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../i18n/strings.g.dart';
import '../current_quest/state/current_quest_cubit.dart';

class NoQuestAssignedWidget extends StatelessWidget {
  const NoQuestAssignedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: context.read<CurrentQuestCubit>().searchForQuest,
        child: Text(t.active_quest.search_button),
      ),
    );
  }
}
