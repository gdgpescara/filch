import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/user_points_cubit.dart';
import 'user_points_item_card.dart';

class UserPointsList extends StatelessWidget {
  const UserPointsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserPointsCubit, UserPointsState, UserPointsLoaded>(
      selector: (state) => state is UserPointsLoaded ? state : const UserPointsLoaded([]),
      builder: (context, loadedState) {
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: loadedState.points.length,
          itemBuilder: (context, index) => UserPointsItemCard(loadedState.points[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        );
      },
    );
  }
}
