import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';
import '../../_shared/widgets/dark_map_container.dart';
import 'state/user_points_cubit.dart';
import 'widgets/user_points_list.dart';

class UserPointsPage extends StatelessWidget {
  const UserPointsPage({super.key});

  static const routeName = 'user-points';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPointsCubit>(
      create: (context) => injector()..loadPoints(),
      child: DarkMapContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text(t.my_points_details.title)),
          body: const UserPointsList(),
        ),
      ),
    );
  }
}
