import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_functionalities/widgets/loader_animation.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import 'state/scan_cubit.dart';
import 'widgets/assignable_points_list.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<ScanCubit>(
        create: (context) => injector()..load(),
        child: BlocBuilder<ScanCubit, ScanState>(
          builder: (context, state) {
            return switch (state) {
              ScanLoading() => const Center(child: LoaderAnimation()),
              ScanLoaded() => const AssignablePointsList(),
              ScanFailure() => Center(child: Text(t.commons.errors.generic)),
            };
          },
        ),
      ),
    );
  }
}