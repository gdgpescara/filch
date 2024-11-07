import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import 'ranking_card.dart';
import 'state/ranking_cubit.dart';

class RankingList extends StatelessWidget {
  const RankingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingCubit, RankingState>(
      buildWhen: (previous, current) => previous != current && current is RankingLoaded,
      builder: (context, state) {
        if (state is RankingLoaded) {
          final list = ListView.separated(
            padding: const EdgeInsets.all(Spacing.m),
            itemCount: state.items.length,
            separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
            itemBuilder: (context, index) => RankingCard(
              item: state.items[index],
              position: index + 1,
              isUser: state.items[index].uid == state.userUid,
            ),
          );

          if (state.rankingFreezed) {
            return ConfettiContainer(child: list);
          }
          return list;
        }
        return const SizedBox();
      },
    );
  }
}
