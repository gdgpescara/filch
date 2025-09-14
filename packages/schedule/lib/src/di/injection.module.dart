//@GeneratedMicroModule;SchedulePackageModule;package:schedule/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/auth.dart' as _i662;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:injectable/injectable.dart' as _i526;
import 'package:schedule/src/models/models.dart' as _i438;
import 'package:schedule/src/presentation/schedule/state/day_sessions_cubit.dart'
    as _i787;
import 'package:schedule/src/presentation/schedule/state/schedule_cubit.dart'
    as _i365;
import 'package:schedule/src/presentation/session_detail/state/session_detail_cubit.dart'
    as _i295;
import 'package:schedule/src/presentation/widgets/state/favorite_cubit.dart'
    as _i578;
import 'package:schedule/src/use_cases/get_grouped_sessions_use_case.dart'
    as _i558;
import 'package:schedule/src/use_cases/get_session_by_id_use_case.dart' as _i73;
import 'package:schedule/src/use_cases/get_user_favorite_sessions_use_case.dart'
    as _i242;
import 'package:schedule/src/use_cases/is_favorite_use_case.dart' as _i901;
import 'package:schedule/src/use_cases/toggle_favorite_use_case.dart' as _i107;

class SchedulePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i901.IsFavoriteUseCase>(() => _i901.IsFavoriteUseCase(
          gh<_i974.FirebaseFirestore>(),
          gh<_i662.GetSignedUserUseCase>(),
        ));
    gh.lazySingleton<_i242.GetUserFavoriteSessionsUseCase>(
        () => _i242.GetUserFavoriteSessionsUseCase(
              gh<_i974.FirebaseFirestore>(),
              gh<_i662.GetSignedUserUseCase>(),
            ));
    gh.lazySingleton<_i558.GetGroupedSessionsUseCase>(
        () => _i558.GetGroupedSessionsUseCase(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i73.GetSessionByIdUseCase>(
        () => _i73.GetSessionByIdUseCase(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i365.ScheduleCubit>(
        () => _i365.ScheduleCubit(gh<_i558.GetGroupedSessionsUseCase>()));
    gh.factoryParam<_i787.DaySessionsCubit, Map<String, List<_i438.Session>>,
        dynamic>((
      sessions,
      _,
    ) =>
        _i787.DaySessionsCubit(sessions));
    gh.lazySingleton<_i107.ToggleFavoriteUseCase>(
        () => _i107.ToggleFavoriteUseCase(gh<_i809.FirebaseFunctions>()));
    gh.factory<_i578.FavoriteCubit>(() => _i578.FavoriteCubit(
          gh<_i107.ToggleFavoriteUseCase>(),
          gh<_i901.IsFavoriteUseCase>(),
        ));
    gh.factory<_i295.SessionDetailCubit>(
        () => _i295.SessionDetailCubit(gh<_i73.GetSessionByIdUseCase>()));
  }
}
