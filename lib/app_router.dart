import 'package:flutter/material.dart';

import 'functionalities/login/login_page.dart';

class AppRouter {
  AppRouter._();

  static const initialRoute = LoginPage.routeName;

  static RouteFactory get generateAppRoute => (settings) => {
        LoginPage.routeName: MaterialPageRoute<void>(
          builder: (context) => const LoginPage(),
          settings: settings,
        ),
      }[settings.name];
}
