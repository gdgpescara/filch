import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

import 'application.dart';
import 'dependency_injection/dependency_injection.config.dart';
import 'dependency_injection/dependency_injection.dart';
import 'firebase_options.dart';
import 'i18n/strings.g.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      LocaleSettings.useDeviceLocale();
      Loggy.initLoggy(
        logPrinter: const PrettyDeveloperPrinter(),
      );
      injector.init();

      if (const String.fromEnvironment('ENV') == 'local') {
        FirebaseFunctions.instance.useFunctionsEmulator(
          const String.fromEnvironment('HOST'),
          const int.fromEnvironment('FUNCTION_PORT'),
        );
        FirebaseFirestore.instance.useFirestoreEmulator(
          const String.fromEnvironment('HOST'),
          const int.fromEnvironment('FIRESTORE_PORT'),
        );
      }

      runApp(TranslationProvider(child: const Application()));
    },
    onBootstrapError,
  );
}

void onBootstrapError(dynamic error, StackTrace stack) => FirebaseCrashlytics.instance.recordError(error, stack);
