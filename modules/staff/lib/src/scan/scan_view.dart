import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../staff.dart';
import 'state/scan_cubit.dart';
import 'widgets/assignable_points_list.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key, required this.navigateToAssignment});

  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<ScanCubit>(
        create: (context) => GetIt.I()..load(),
        child: BlocBuilder<ScanCubit, ScanState>(
          builder: (context, state) {
            return switch (state) {
              ScanLoading() => const Center(child: LoaderAnimation()),
              ScanLoaded() => AssignablePointsList(navigateToAssignment),
              ScanFailure() => Center(child: Text(t.common.errors.generic)),
            };
          },
        ),
      ),
    );
  }
}
