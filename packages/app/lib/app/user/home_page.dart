import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:user/user.dart';

import '../../application.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserHomePage(
      navigateToLogin: () => Routefly.navigate(routePaths.signIn),
      navigateToSplash: () => Routefly.navigate(routePaths.path),
      navigateToAllPoints: () => Routefly.pushNavigate(routePaths.user.allPoints),
    );
  }
}
