import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  includeMicroPackages: false,
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(AuthPackageModule),
  ],
)
Future<void> initAppInjectorModule() async {}
