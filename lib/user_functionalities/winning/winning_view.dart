import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_functionalities/widgets/dark_map_container.dart';
import '../../common_functionalities/widgets/loader_animation.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import 'state/winner_house_cubit.dart';
import 'widgets/winner_house_view_content.dart';

class WinningView extends StatelessWidget {
  const WinningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DarkMapContainer(
          child: BlocProvider<WinnerHouseCubit>(
            create: (_) => injector()..loadHouse(),
            child: Builder(
              builder: (context) {
                return BlocBuilder<WinnerHouseCubit, WinnerHouseState>(
                  builder: (context, state) {
                    return switch (state) {
                      WinnerHouseLoading() => const Center(child: LoaderAnimation()),
                      WinnerHouseFailure() => Center(child: Text(t.commons.errors.generic_retry)),
                      WinnerHouseLoaded() => WinnerHouseViewContent(house: state.house),
                    };
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
