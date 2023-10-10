import 'package:flutter/material.dart';

import 'functionalities/home/home_page.dart';
import 'functionalities/login/login_page.dart';
import 'functionalities/sorting_ceremony/sorting_ceremony_page.dart';
import 'functionalities/splash/splash_page.dart';

class AppRouter {
  AppRouter._();

  static const initialRoute = SplashPage.routeName;

  static RouteFactory get generateAppRoute => (settings) => {
        SplashPage.routeName: MaterialPageRoute<void>(
          builder: (context) => const SplashPage(),
          settings: settings,
        ),
        LoginPage.routeName: MaterialPageRoute<void>(
          builder: (context) => const LoginPage(),
          fullscreenDialog: true,
          settings: settings,
        ),
        SortingCeremonyPage.routeName: MaterialPageRoute<void>(
          builder: (context) => const SortingCeremonyPage(),
          fullscreenDialog: true,
          settings: settings,
        ),
        HomePage.routeName: MaterialPageRoute<void>(
          builder: (context) => const HomePage(),
          settings: settings,
        ),
      }[settings.name];
}
