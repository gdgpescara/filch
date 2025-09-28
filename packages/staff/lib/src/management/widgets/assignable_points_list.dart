import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

import '../../../staff.dart';
import '../state/management_cubit.dart';
import 'free_points_list.dart';
import 'user_quest_list.dart';

class AssignablePointsList extends StatelessWidget {
  const AssignablePointsList(this.navigateToAssignment, {super.key});

  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocSelector<ManagementCubit, ManagementState, List<Quest>>(
          selector: (state) => state is ManagementLoaded ? state.quests : [],
          builder: (context, quests) {
            if (quests.isEmpty) return const SizedBox();
            return UserQuestList(navigateToAssignment);
          },
        ),
        const Gap.vertical(Spacing.xl),
        FreePointsList(navigateToAssignment),
      ],
    );
  }
}
