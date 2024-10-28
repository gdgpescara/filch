import 'dart:async';

import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:auth/auth.dart';
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
  late StreamSubscription<RemoteMessage> _subscription;
  final _router = Routefly.routerConfig(
    initialPath: routePaths.path,
    routes: routes,
    routeBuilder: routeBuilder,
  );

  @override
  void initState() {
    super.initState();
    GetIt.I<UploadFcmTokenUseCase>()();
    _subscription = FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        Routefly.pushNavigate(routePaths.notification, arguments: message.notification);
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => GetIt.I(),
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Routefly.navigate(routePaths.path);
          }
        },
        child: MaterialApp.router(
          locale: TranslationProvider.of(context).flutterLocale,
          themeMode: ThemeMode.dark,
          theme: buildTheme(Brightness.dark),
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
