import 'package:flutter/material.dart';

import 'functionalities/home/home_page.dart';
import 'functionalities/sign_in/sign_in_page.dart';
import 'functionalities/sorting_ceremony/sorting_ceremony_page.dart';
import 'functionalities/splash/splash_page.dart';
import 'functionalities/user/user_points/user_points_page.dart';

class AppRouter {
  AppRouter._();

  static const initialRoute = SplashPage.routeName;

  static RouteFactory get generateAppRoute => (settings) => {
        SplashPage.routeName: _pageRouteBuilder<void>(const SplashPage()),
        SignInPage.routeName: _pageRouteBuilder<void>(const SignInPage()),
        SortingCeremonyPage.routeName: _pageRouteBuilder<void>(const SortingCeremonyPage()),
        HomePage.routeName: _pageRouteBuilder<void>(const HomePage()),
        UserPointsPage.routeName: _pageRouteBuilder<void>(const UserPointsPage()),
      }[settings.name];

  static PageRouteBuilder<T> _pageRouteBuilder<T>(Widget child) => PageRouteBuilder<T>(
        pageBuilder: (_, __, ___) => child,
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      );
}
