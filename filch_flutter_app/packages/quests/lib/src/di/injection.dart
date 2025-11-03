import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(
  ignoreUnregisteredTypesInPackages: ['core', 'auth', 'cloud_functions', 'cloud_firestore', 'firebase_auth'],
)
Future<void> configureDependencies() async {}
