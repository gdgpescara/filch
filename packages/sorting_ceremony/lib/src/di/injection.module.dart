//@GeneratedMicroModule;SortingCeremonyPackageModule;package:sorting_ceremony/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/auth.dart' as _i662;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sorting_ceremony/sorting_ceremony.dart' as _i363;
import 'package:sorting_ceremony/src/state/sorting_ceremony_cubit.dart' as _i111;
import 'package:sorting_ceremony/src/use_cases/assign_team_use_case.dart' as _i802;
import 'package:sorting_ceremony/src/use_cases/user_need_sorting_ceremony_use_case.dart' as _i702;

class SortingCeremonyPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i702.UserNeedSortingCeremonyUseCase>(
      () => _i702.UserNeedSortingCeremonyUseCase(
        gh<_i59.FirebaseAuth>(),
        gh<_i662.SignOutUseCase>(),
      ),
    );
    gh.lazySingleton<_i802.AssignTeamUseCase>(() => _i802.AssignTeamUseCase(gh<_i809.FirebaseFunctions>()));
    gh.factory<_i111.SortingCeremonyCubit>(() => _i111.SortingCeremonyCubit(gh<_i363.AssignTeamUseCase>()));
  }
}
