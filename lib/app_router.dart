import 'package:flutter/material.dart';

import 'common_functionalities/sign_in/sign_in_page.dart';
import 'common_functionalities/splash/splash_page.dart';
import 'staff_functionalities/assignment/assignment_page.dart';
import 'staff_functionalities/home/staff_home_page.dart';
import 'user_functionalities/home/user_home_page.dart';
import 'user_functionalities/sorting_ceremony/sorting_ceremony_page.dart';
import 'user_functionalities/user_points/user_points_page.dart';

class AppRouter {
  AppRouter._();

  static const initialRoute = SplashPage.routeName;

  static RouteFactory get generateAppRoute => (settings) => {
        SplashPage.routeName: _pageRouteBuilder<void>(const SplashPage()),
        SignInPage.routeName: _pageRouteBuilder<void>(const SignInPage()),
        SortingCeremonyPage.routeName: _pageRouteBuilder<void>(const SortingCeremonyPage()),
        UserHomePage.routeName: _pageRouteBuilder<void>(const UserHomePage()),
        UserPointsPage.routeName: _pageRouteBuilder<void>(const UserPointsPage()),
        StaffHomePage.routeName: _pageRouteBuilder<void>(const StaffHomePage()),
        AssignmentPage.routeName: _pageRouteBuilder<void>(const AssignmentPage()),
      }[settings.name];

  static PageRouteBuilder<T> _pageRouteBuilder<T>(Widget child) => PageRouteBuilder<T>(
        pageBuilder: (_, __, ___) => child,
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      );
}
