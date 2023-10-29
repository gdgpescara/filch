import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../_shared/models/house.dart';
import '../state/houses_ranking_cubit.dart';
import 'houses_ranking_card.dart';

class HousesRankingList extends StatelessWidget {
  const HousesRankingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HousesRankingCubit, HousesRankingState, HousesRankingLoaded>(
      selector: (state) => state is HousesRankingLoaded ? state : const HousesRankingLoaded(null, houses: []),
      builder: (context, loadedState) {
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: loadedState.houses.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) => HousesRankingCard(
            house: loadedState.houses[index],
            position: index + 1,
            isUserHouse: loadedState.houses[index].id == loadedState.userHouse,
          ),
        );
      },
    );
  }
}
