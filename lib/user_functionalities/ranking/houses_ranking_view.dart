import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_functionalities/widgets/loader_animation.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import '../winning/winning_view.dart';
import 'state/houses_ranking_cubit.dart';
import 'widgets/houses_ranking_list.dart';

class HousesRankingView extends StatelessWidget {
  const HousesRankingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<HousesRankingCubit>(
        create: (_) => injector()..init(),
        child: BlocBuilder<HousesRankingCubit, HousesRankingState>(
          builder: (context, state) {
            return switch (state) {
              HousesRankingLoading() => const Center(child: LoaderAnimation()),
              HousesRankingLoaded() => const HousesRankingList(),
              HousesRankingFailure() => Center(child: Text(t.commons.errors.generic_retry)),
              HousesRankingFreezed() => const WinningView(),
            };
          },
        ),
      ),
    );
  }
}
