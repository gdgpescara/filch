import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../commons/quest_description_widget.dart';
import '../current_quest/state/current_quest_cubit.dart';
import '../models/quest__sub_types_enum.dart';
import 'qr_code/social_scan_view.dart';

class SocialQuestWidget extends StatelessWidget {
  const SocialQuestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
      buildWhen: (previous, current) => current is CurrentQuestLoaded,
      builder: (context, state) {
        state as CurrentQuestLoaded;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuestDescriptionWidget(activeQuest: state.activeQuest),
            const SizedBox(height: 20),
            switch (state.activeQuest.quest.subType) {
              QuestSubTypeEnum.qrCode => const SocialScanView(),
              _ => const SizedBox(),
            },
          ],
        );
      },
    );
  }
}
