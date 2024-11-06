import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:staff/staff.dart';

import '../../routes.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StaffHomePage(
      navigateToSplash: () => Routefly.navigate(routePaths.path),
      navigateToAssignment: (args) => Routefly.pushNavigate(
        routePaths.staff.pointAssignment,
        arguments: args.copyWith(onAssignDone: Routefly.pop<void>),
      ),
      navigateToTShirtAssignment: () => Routefly.pushNavigate(routePaths.staff.tShirtAssignment),
    );
  }
}
