import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_functionalities/widgets/loader_animation.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import 'state/shifts_cubit.dart';
import 'widgets/shift_planner.dart';

class ShiftsView extends StatelessWidget {
  const ShiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShiftsCubit>(
      create: (context) => injector()..init(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text(t.shifts.title),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: BlocBuilder<ShiftsCubit, ShiftsState>(
              builder: (context, state) {
                return switch (state) {
                  ShiftsLoading() => const Center(child: LoaderAnimation()),
                  ShiftsLoaded() => ShiftPlanner(shifts: state.shifts),
                  ShiftsFailure() => Center(child: Text(t.commons.errors.generic)),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
