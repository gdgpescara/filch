import 'package:flutter/material.dart';

import 'functionalities/home/home_page.dart';
import 'functionalities/sign_in/sign_in_page.dart';
import 'functionalities/sorting_ceremony/sorting_ceremony_page.dart';
import 'functionalities/splash/splash_page.dart';

class AppRouter {
  AppRouter._();

  static const initialRoute = SplashPage.routeName;

  static RouteFactory get generateAppRoute => (settings) => {
        SplashPage.routeName: PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const SplashPage(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        ),
        SignInPage.routeName: PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const SignInPage(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        ),
        SortingCeremonyPage.routeName: PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const SortingCeremonyPage(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        ),
        HomePage.routeName: PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        ),
      }[settings.name];
}
