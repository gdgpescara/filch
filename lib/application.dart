import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_router.dart';
import 'common_functionalities/splash/splash_page.dart';
import 'common_functionalities/state/app_cubit.dart';
import 'dependency_injection/dependency_injection.dart';
import 'i18n/strings.g.dart';
import 'theme/app_theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

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
