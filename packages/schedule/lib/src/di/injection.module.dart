//@GeneratedMicroModule;SchedulePackageModule;package:schedule/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:injectable/injectable.dart' as _i526;
import 'package:schedule/src/use_cases/get_grouped_sessions_use_case.dart'
    as _i558;

class SchedulePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i558.GetGroupedSessionsUseCase>(
        () => _i558.GetGroupedSessionsUseCase(gh<_i974.FirebaseFirestore>()));
  }
}
