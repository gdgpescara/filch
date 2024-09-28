import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';
import 'package:sorting_ceremony/sorting_ceremony.dart';
import 'package:user/user.dart';

@InjectableInit(
  includeMicroPackages: false,
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(AuthPackageModule),
    ExternalModule(SortingCeremonyPackageModule),
    ExternalModule(QuestsPackageModule),
    ExternalModule(UserPackageModule),
  ],
)
Future<void> initAppInjectorModule() async {}
