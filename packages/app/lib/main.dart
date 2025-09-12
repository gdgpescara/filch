import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:loggy/loggy.dart';

import 'application.dart';
import 'catch_and_flow_logger.dart';
import 'di/app_di.config.dart';
import 'firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await LocaleSettings.useDeviceLocale();
    Loggy.initLoggy(logPrinter: const PrettyDeveloperPrinter());
    CatchAndFlow.setLogger(CatchAndFlowLoggerLoggy());
    await GetIt.I.init();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await FirebaseMessaging.instance.requestPermission(provisional: true);

    if (const String.fromEnvironment('ENV') == 'local') {
      await FirebaseAuth.instance.useAuthEmulator(
        const String.fromEnvironment('HOST'),
        const int.fromEnvironment('AUTH_PORT'),
      );
      FirebaseFunctions.instance.useFunctionsEmulator(
        const String.fromEnvironment('HOST'),
        const int.fromEnvironment('FUNCTION_PORT'),
      );
      FirebaseFirestore.instance.useFirestoreEmulator(
        const String.fromEnvironment('HOST'),
        const int.fromEnvironment('FIRESTORE_PORT'),
      );
    }

    if (kDebugMode) {
      await FirebaseAppCheck.instance.activate(
        androidProvider: AndroidProvider.debug,
        appleProvider: AppleProvider.debug,
      );
    }

    if (kReleaseMode) {
      await FirebaseAppCheck.instance.activate(appleProvider: AppleProvider.appAttest);
      await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
    }

    runApp(TranslationProvider(child: const Application()));
  }, onBootstrapError);
}

void onBootstrapError(dynamic error, StackTrace stack) => FirebaseCrashlytics.instance.recordError(error, stack);
