import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(ignoreUnregisteredTypesInPackages: ['core', 'auth', 'quests', 'cloud_firestore'])
Future<void> configureDependencies() async {}
