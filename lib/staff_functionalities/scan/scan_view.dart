import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependency_injection/dependency_injection.dart';
import 'state/scan_cubit.dart';
import 'widgets/assignable_points_list.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScanCubit>(
      create: (context) => injector()..load(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ScanCubit, ScanState>(
          builder: (context, state) {
            return switch (state) {
              ScanLoading() => const CircularProgressIndicator(),
              ScanFailure() => Container(),
              ScanLoaded() => AssignablePointsList(points: state.points, quests: state.quests),
            };
          },
        ),
      ),
    );
  }
}
