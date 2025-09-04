//@GeneratedMicroModule;UserPackageModule;package:user/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/auth.dart' as _i662;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:injectable/injectable.dart' as _i526;
import 'package:quests/quests.dart' as _i177;
import 'package:user/src/home/state/home_page_cubit.dart' as _i251;
import 'package:user/src/points/state/user_points_cubit.dart' as _i109;
import 'package:user/src/profile/state/user_profile_cubit.dart' as _i343;
import 'package:user/src/profile/t_shirt/state/user_t_shirt_cubit.dart' as _i120;
import 'package:user/src/use_cases/t_shirt_pick_up_state_use_case.dart' as _i899;

class UserPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i343.UserProfileCubit>(
      () => _i343.UserProfileCubit(
        gh<_i662.GetSignedUserUseCase>(),
        gh<_i662.SignOutUseCase>(),
      ),
    );
    gh.factory<_i109.UserPointsCubit>(() => _i109.UserPointsCubit(gh<_i177.GetSignedUserPointsUseCase>()));
    gh.factory<_i251.HomePageCubit>(() => _i251.HomePageCubit(gh<_i177.IsRankingFreezedUseCase>()));
    gh.lazySingleton<_i899.TShirtPickUpStateUseCase>(
      () => _i899.TShirtPickUpStateUseCase(
        gh<_i974.FirebaseFirestore>(),
        gh<_i662.GetSignedUserUseCase>(),
      ),
    );
    gh.factory<_i120.UserTShirtCubit>(() => _i120.UserTShirtCubit(gh<_i899.TShirtPickUpStateUseCase>()));
  }
}
