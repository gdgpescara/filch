import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:routefly/routefly.dart';
import 'package:ui/ui.dart';

import '../../application.dart';
import 'state/bootstrap_cubit.dart';

part 'state/state_listener.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BootstrapCubit>(
      create: (context) => GetIt.I()..init(),
      child: BlocListener<BootstrapCubit, BootstrapState>(
        listener: _stateListener,
        child: Scaffold(
          backgroundColor: context.colorScheme.surface,
          body: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Logo(),
                Gap.vertical(Spacing.xxl),
                LoaderAnimation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
