import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/assignment_cubit.dart';
import 'scanned_item.dart';

class ScannedItems extends StatelessWidget {
  const ScannedItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AssignmentCubit, AssignmentState, List<String>>(
      selector: (state) => state is AssignmentInitial ? state.scannedUsers : [],
      builder: (context, users) {
        return Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            itemCount: users.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) => ScannedItem(users[index]),
          ),
        );
      },
    );
  }
}
