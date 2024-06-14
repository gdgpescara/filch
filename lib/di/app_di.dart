import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final injector = GetIt.asNewInstance();

@InjectableInit(
  includeMicroPackages: false,
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(AuthPackageModule),
  ],
)
Future<void> initAppInjectorModule() async {}
