import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'state/shifts_cubit.dart';
import 'widgets/shift_planner.dart';

class ShiftsView extends StatelessWidget {
  const ShiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShiftsCubit>(
      create: (context) => GetIt.I()..init(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(elevation: 0, title: Text(t.staff.shifts.title)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: BlocBuilder<ShiftsCubit, ShiftsState>(
              builder: (context, state) {
                return switch (state) {
                  ShiftsLoading() => const Center(child: LoaderAnimation()),
                  ShiftsLoaded() => ShiftPlanner(shifts: state.shifts),
                  ShiftsFailure() => Center(child: Text(t.common.errors.generic)),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
