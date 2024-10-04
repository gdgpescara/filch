import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../commons/quest_description_widget.dart';
import '../current_quest/state/current_quest_cubit.dart';
import 'quest_qr_code_widget.dart';

class ActorQuestWidget extends StatelessWidget {
  const ActorQuestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CurrentQuestCubit, CurrentQuestState, CurrentQuestLoaded?>(
      selector: (state) => state is CurrentQuestLoaded ? state : null,
      builder: (context, state) {
        if (state == null) return const SizedBox();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuestDescriptionWidget(activeQuest: state.activeQuest),
            const SizedBox(height: 20),
            QuestQrCodeWidget(user: state.user),
          ],
        );
      },
    );
  }
}
