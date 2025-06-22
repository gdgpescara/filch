import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(ignoreUnregisteredTypesInPackages: ['auth', 'quests', 'cloud_firestore'])
Future<void> configureDependencies() async {}
