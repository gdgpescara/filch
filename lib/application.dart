import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_router.dart';
import 'common_functionalities/splash/splash_page.dart';
import 'common_functionalities/state/app_cubit.dart';
import 'dependency_injection/dependency_injection.dart';
import 'i18n/strings.g.dart';
import 'theme/app_theme.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late StreamSubscription<RemoteMessage> _subscription;

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
                  child: Text(t.commons.buttons.ok),
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
    return BlocProvider<AppCubit>(
      create: (context) => injector(),
      child: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AppUnauthenticated) {
            Navigator.pushNamedAndRemoveUntil(context, SplashPage.routeName, (route) => false);
          }
        },
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          locale: TranslationProvider.of(context).flutterLocale,
          themeMode: ThemeMode.dark,
          darkTheme: darkTheme(),
          theme: lightTheme(),
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          initialRoute: AppRouter.initialRoute,
          onGenerateRoute: AppRouter.generateAppRoute,
        ),
      ),
    );
  }
}
