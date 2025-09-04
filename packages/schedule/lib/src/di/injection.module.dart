//@GeneratedMicroModule;SchedulePackageModule;package:schedule/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:injectable/injectable.dart' as _i526;
import 'package:schedule/src/presentation/schedule/cubit/schedule_cubit.dart' as _i307;
import 'package:schedule/src/use_cases/bookmark_use_cases.dart' as _i679;
import 'package:schedule/src/use_cases/get_grouped_sessions_use_case.dart' as _i558;
import 'package:schedule/src/use_cases/get_session_by_id_use_case.dart' as _i73;

class SchedulePackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i679.ToggleSessionBookmarkUseCase>(() => const _i679.ToggleSessionBookmarkUseCase());
    gh.lazySingleton<_i679.IsSessionBookmarkedUseCase>(() => const _i679.IsSessionBookmarkedUseCase());
    gh.lazySingleton<_i558.GetGroupedSessionsUseCase>(
      () => _i558.GetGroupedSessionsUseCase(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i73.GetSessionByIdUseCase>(() => _i73.GetSessionByIdUseCase(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i307.ScheduleCubit>(
      () => _i307.ScheduleCubit(
        gh<_i558.GetGroupedSessionsUseCase>(),
        gh<_i679.ToggleSessionBookmarkUseCase>(),
        gh<_i679.IsSessionBookmarkedUseCase>(),
      ),
    );
  }
}
