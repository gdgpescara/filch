import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../commons/active_quest/quest_description_widget.dart';
import '../commons/active_quest/quest_prompt_widget.dart';
import '../commons/active_quest/quest_qr_code_widget.dart';
import '../current_quest/state/current_quest_cubit.dart';

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
            if (state.activeQuest.prompt != null) QuestPromptWidget(state.activeQuest.prompt!),
            const SizedBox(height: Spacing.l),
            QuestQrCodeWidget(user: state.user),
          ],
        );
      },
    );
  }
}
