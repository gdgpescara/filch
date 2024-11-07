import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'ranking_card.dart';
import 'ranking_list.dart';
import 'state/ranking_cubit.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RankingCubit>(
      create: (context) => GetIt.I()..init(),
      child: Scaffold(
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.only(top: Spacing.xxl),
          child: BlocBuilder<RankingCubit, RankingState>(
            buildWhen: (previous, current) => current is! YourRankingState,
            builder: (context, state) {
              return switch (state) {
                RankingLoading() => const Center(child: LoaderAnimation()),
                RankingLoaded() => const RankingList(),
                RankingFailure() => Center(child: Text(t.common.errors.generic_retry)),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<RankingCubit, RankingState>(
          buildWhen: (previous, current) => current is YourRankingState,
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(Spacing.s),
              height: 115 + Spacing.s * 2,
              child: switch (state) {
                YourRankingLoading() => const LoaderAnimation(),
                YourRankingLoaded(item: final item, position: final position) => DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colorScheme.tertiary.withOpacity(0.2),
                    ),
                    child: RankingCard(
                      item: item,
                      position: position,
                      isUser: true,
                      style: AppCardStyle.caption,
                    ),
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
