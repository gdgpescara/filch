import 'package:flutter/material.dart';

Route<T> routeBuilder<T>(BuildContext context, RouteSettings settings, Widget page) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) {
      return FadeTransition(opacity: animation, child: page);
    },
  );
}
