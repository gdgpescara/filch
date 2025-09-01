import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:media_manager/media_manager.dart';
import 'package:quests/quests.dart';
import 'package:sorting_ceremony/sorting_ceremony.dart';
import 'package:staff/staff.dart';
import 'package:user/user.dart';

@InjectableInit(
  includeMicroPackages: false,
  externalPackageModulesBefore: [
    ExternalModule(CorePackageModule),
    ExternalModule(AuthPackageModule),
    ExternalModule(SortingCeremonyPackageModule),
    ExternalModule(QuestsPackageModule),
    ExternalModule(UserPackageModule),
    ExternalModule(StaffPackageModule),
    ExternalModule(MediaManagerPackageModule),
  ],
)
Future<void> initAppInjectorModule() async {}
