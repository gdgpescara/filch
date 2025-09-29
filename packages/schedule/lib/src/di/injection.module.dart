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
import 'package:schedule/schedule.dart' as _i199;
import 'package:schedule/src/models/models.dart' as _i438;
import 'package:schedule/src/presentation/schedule/state/day_sessions_cubit.dart' as _i787;
import 'package:schedule/src/presentation/schedule/state/schedule_cubit.dart' as _i365;
import 'package:schedule/src/presentation/session_detail/state/session_detail_cubit.dart' as _i295;
import 'package:schedule/src/presentation/widgets/state/favorite_cubit.dart' as _i578;
import 'package:schedule/src/use_cases/get_grouped_sessions_use_case.dart' as _i558;
import 'package:schedule/src/use_cases/get_max_room_delay_use_case.dart' as _i707;
import 'package:schedule/src/use_cases/get_room_delay_use_case.dart' as _i882;
import 'package:schedule/src/use_cases/get_rooms_use_case.dart' as _i234;
import 'package:schedule/src/use_cases/get_session_by_id_use_case.dart' as _i73;
import 'package:schedule/src/use_cases/get_user_favorite_session_ids_use_case.dart' as _i634;
import 'package:schedule/src/use_cases/register_room_delay_use_case.dart' as _i85;
import 'package:schedule/src/use_cases/toggle_favorite_use_case.dart' as _i107;

class SchedulePackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factoryParam<_i787.DaySessionsCubit, List<_i438.RoomSessions>, dynamic>(
      (
        sessions,
        _,
      ) => _i787.DaySessionsCubit(sessions),
    );
    gh.lazySingleton<_i634.GetUserFavoriteSessionIdsUseCase>(
      () => _i634.GetUserFavoriteSessionIdsUseCase(
        gh<_i974.FirebaseFirestore>(),
        gh<_i662.GetSignedUserUseCase>(),
      ),
    );
    gh.lazySingleton<_i234.GetRoomsUseCase>(() => _i234.GetRoomsUseCase(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i882.GetRoomDelayUseCase>(() => _i882.GetRoomDelayUseCase(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i707.GetMaxRoomDelayUseCase>(() => _i707.GetMaxRoomDelayUseCase(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i107.ToggleFavoriteUseCase>(() => _i107.ToggleFavoriteUseCase(gh<_i809.FirebaseFunctions>()));
    gh.lazySingleton<_i85.RegisterRoomDelayUseCase>(() => _i85.RegisterRoomDelayUseCase(gh<_i809.FirebaseFunctions>()));
    gh.lazySingleton<_i558.GetGroupedSessionsUseCase>(
      () => _i558.GetGroupedSessionsUseCase(
        gh<_i974.FirebaseFirestore>(),
        gh<_i199.GetUserFavoriteSessionIdsUseCase>(),
        gh<_i199.GetMaxRoomDelayUseCase>(),
      ),
    );
    gh.lazySingleton<_i73.GetSessionByIdUseCase>(
      () => _i73.GetSessionByIdUseCase(
        gh<_i974.FirebaseFirestore>(),
        gh<_i634.GetUserFavoriteSessionIdsUseCase>(),
        gh<_i707.GetMaxRoomDelayUseCase>(),
      ),
    );
    gh.factory<_i578.FavoriteCubit>(() => _i578.FavoriteCubit(gh<_i107.ToggleFavoriteUseCase>()));
    gh.factory<_i365.ScheduleCubit>(() => _i365.ScheduleCubit(gh<_i558.GetGroupedSessionsUseCase>()));
    gh.factory<_i295.SessionDetailCubit>(() => _i295.SessionDetailCubit(gh<_i73.GetSessionByIdUseCase>()));
  }
}
