import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user_functionalities/quests/models/quest.dart';
import '../state/scan_cubit.dart';
import 'free_points_list.dart';
import 'user_quest_list.dart';

class AssignablePointsList extends StatelessWidget {
  const AssignablePointsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const FreePointsList(),
        const SizedBox(height: 24),
        BlocSelector<ScanCubit, ScanState, List<Quest>>(
          selector: (state) => state is ScanLoaded ? state.quests : [],
          builder: (context, quests) {
            if (quests.isEmpty) return const SizedBox();
            return const UserQuestList();
          },
        ),
      ],
    );
  }
}
