import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_router.dart';
import 'i18n/strings.g.dart';
import 'theme/app_theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      theme: lightTheme,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.generateAppRoute,
    );
  }
}
