import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(
  ignoreUnregisteredTypesInPackages: [
    'auth',
    'quests',
  ],
)
Future<void> configureDependencies() async {}
