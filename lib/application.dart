import 'dart:async';

import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:routefly/routefly.dart';
import 'package:ui/ui.dart';

import 'auth_state/auth_cubit.dart';
import 'routes.g.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late StreamSubscription<RemoteMessage> _subscription;
  final _router = Routefly.routerConfig(
    initialPath: routePaths.path,
    routes: routes,
    routeBuilder: routeBuilder,
  );

  @override
  void initState() {
    super.initState();
    _subscription = FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null && _navigatorKey.currentContext != null) {
        showAdaptiveDialog<void>(
          context: _navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: Text(message.notification!.title ?? ''),
              content: Text(message.notification!.body ?? ''),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(t.common.buttons.ok),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => GetIt.I(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Routefly.replace(routePaths.path);
          }
        },
        child: MaterialApp.router(
          locale: TranslationProvider.of(context).flutterLocale,
          themeMode: ThemeMode.dark,
          darkTheme: buildTheme(Brightness.dark),
          theme: buildTheme(Brightness.light),
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          routerConfig: _router,
          themeAnimationCurve: Curves.easeInOut,
          themeAnimationDuration: const Duration(milliseconds: 600),
          builder: (context, child) {
            return AccessibilityTools(
              checkFontOverflows: true,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
