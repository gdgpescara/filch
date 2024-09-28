import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:user/user.dart';

import '../../routes.g.dart';
import '../../widgets/gradient_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserHomePage(
      backGroundBuilder: ({required child}) => GradientBackground(child: child),
      navigateToLogin: () => Routefly.navigate(routePaths.signIn),
      navigateToSplash: () => Routefly.navigate(routePaths.path),
      navigateToAllPoints: () => Routefly.pushNavigate(routePaths.user.allPoints),
    );
  }
}
