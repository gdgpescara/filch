import 'package:auth/auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../application.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return auth.SignInPage(onSignedInNavigateTo: () => Routefly.navigate(routePaths.path));
  }
}
