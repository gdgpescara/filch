import 'package:filch/functionalities/sorting_ceremony/widgets/sorting_failure.dart';
import 'package:filch/functionalities/sorting_ceremony/widgets/sorting_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependency_injection/dependency_injection.dart';
import 'state/sorting_ceremony_cubit.dart';
import 'widgets/sorting_success.dart';

class SortingCeremonyPage extends StatelessWidget {
  const SortingCeremonyPage({super.key});

  static const routeName = 'sorting_ceremony';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SortingCeremonyCubit>(
      create: (context) => injector()..startSortingCeremony(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/old_map_dark.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocConsumer<SortingCeremonyCubit, SortingCeremonyState>(
              listenWhen: (previous, current) => current is SortingCeremonyEvent,
              listener: (context, state) {
                if (state is SortingCeremonyFinish) {
                  Navigator.pop(context);
                }
              },
              buildWhen: (previous, current) => current is! SortingCeremonyEvent,
              builder: (context, state) {
                final child = switch (state) {
                  SortingCeremonyLoading() => const SortingLoading(),
                  SortingCeremonySuccess(house: final house) => SortingSuccess(house: house),
                  SortingCeremonyFailure(failure: final failure) => SortingFailure(failure: failure),
                  _ => const SizedBox.shrink(),
                };
                return AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: child);
              },
            ),
          ),
        ),
      ),
    );
  }
}
