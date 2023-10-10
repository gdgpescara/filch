import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'application.dart';
import 'dependecy_injection/dependecy_injection.dart';
import 'firebase_options.dart';
import 'i18n/strings.g.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    LocaleSettings.useDeviceLocale();
    await initAppInjectorModule();

    runApp(TranslationProvider(child: const Application()));
  }, onBootstrapError,);
}

void onBootstrapError(dynamic error, StackTrace stack) =>
    FirebaseCrashlytics.instance.recordError(error, stack);
