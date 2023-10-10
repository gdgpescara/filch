import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final injector = GetIt.asNewInstance();

@InjectableInit()
Future<void> initAppInjectorModule() async {}

@module
abstract class ExternalPackages {
}
