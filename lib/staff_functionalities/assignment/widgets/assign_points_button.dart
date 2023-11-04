import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../i18n/strings.g.dart';
import '../assignment_page.dart';
import '../state/assignment_cubit.dart';

class AssignPointsButton extends StatelessWidget {
  const AssignPointsButton({super.key, required this.args});

  final AssignmentPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AssignmentCubit, AssignmentState, List<String>>(
      selector: (state) => state is AssignmentInitial ? state.scannedUsers : [],
      builder: (context, users) {
        return ElevatedButton(
          onPressed: users.isNotEmpty
              ? () => context.read<AssignmentCubit>().assign(
                    points: args.points,
                    quest: args.quest,
                    type: args.type,
                    users: users.map((e) => (jsonDecode(e) as Map<String, dynamic>)['uid'] as String).toList(),
                  )
              : null,
          child: Text(t.point_assignment.page.assign_button),
        );
      },
    );
  }
}
