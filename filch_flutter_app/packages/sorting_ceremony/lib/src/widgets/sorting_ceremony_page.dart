import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/ui.dart';

import '../../sorting_ceremony.dart';

class SortingCeremonyPage extends StatelessWidget {
  const SortingCeremonyPage({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SortingCeremonyCubit>(
      create: (context) => GetIt.I()..startSortingCeremony(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Background(
            child: BlocConsumer<SortingCeremonyCubit, SortingCeremonyState>(
              listenWhen: (previous, current) => current is SortingCeremonyEvent,
              listener: (context, state) {
                if (state is SortingCeremonyFinish) {
                  onDone();
                }
              },
              buildWhen: (previous, current) => current is! SortingCeremonyEvent,
              builder: (context, state) {
                final child = switch (state) {
                  SortingCeremonyLoading() => const SortingLoading(),
                  SortingCeremonySuccess(team: final team) => SortingSuccess(team: team),
                  SortingCeremonyFailure(failure: final failure) => SortingFailure(failure: failure),
                  _ => const SizedBox.shrink(),
                };
                return AnimatedSwitcher(duration: const Duration(milliseconds: 1500), child: child);
              },
            ),
          ),
        ),
      ),
    );
  }
}
