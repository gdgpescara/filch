import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/src/ranking/ranking_card.dart';
import 'package:quests/src/ranking/ranking_list.dart';
import 'package:quests/src/ranking/state/ranking_cubit.dart';
import 'package:quests/src/winner/winning_view.dart';
import 'package:ui/ui.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RankingCubit>(
      create: (context) => GetIt.I()..init(),
      child: Scaffold(
        appBar: AppBar(),
        extendBody: true,
        body: BlocBuilder<RankingCubit, RankingState>(
          buildWhen: (previous, current) => current is! YourRankingState,
          builder: (context, state) {
            return switch (state) {
              RankingLoading() => const Center(child: LoaderAnimation()),
              RankingLoaded() => const RankingList(),
              RankingFailure() => Center(child: Text(t.common.errors.generic_retry)),
              RankingFreezed() => const WinningView(),
              _ => const SizedBox.shrink(),
            };
          },
        ),
        bottomNavigationBar: BlocBuilder<RankingCubit, RankingState>(
          buildWhen: (previous, current) => current is YourRankingState,
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(Spacing.l),
              height: 110 + Spacing.l * 2,
              child: switch (state) {
                YourRankingLoading() => const LoaderAnimation(),
                YourRankingLoaded(item: final item, position: final position) => RankingCard(
                    item: item,
                    position: position,
                    isUser: true,
                  ),
                YourRankingFailure() => Text(t.common.errors.generic_retry),
                _ => const SizedBox.shrink(),
              },
            );
          },
        ),
      ),
    );
  }
}
