import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'state/user_points_cubit.dart';
import 'widgets/user_points_list.dart';

class UserPointsPage extends StatelessWidget {
  const UserPointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPointsCubit>(
      create: (context) => GetIt.I()..loadPoints(),
      child: Background(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text(t.user.my_points_details.title)),
          body: const UserPointsList(),
        ),
      ),
    );
  }
}
