//@GeneratedMicroModule;AuthPackageModule;package:auth/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/auth.dart' as _i662;
import 'package:auth/src/di/external_libraries.dart' as _i969;
import 'package:auth/src/state/sign_in_cubit.dart' as _i299;
import 'package:auth/src/use_cases/apple_sign_in_use_case.dart' as _i1021;
import 'package:auth/src/use_cases/auth_state_changes_use_case.dart' as _i184;
import 'package:auth/src/use_cases/count_users_with_t_shirt_use_case.dart'
    as _i714;
import 'package:auth/src/use_cases/count_users_without_t_shirt_use_case.dart'
    as _i173;
import 'package:auth/src/use_cases/get_signed_user_team_use_case.dart' as _i491;
import 'package:auth/src/use_cases/get_signed_user_use_case.dart' as _i704;
import 'package:auth/src/use_cases/google_sign_in_use_case.dart' as _i395;
import 'package:auth/src/use_cases/has_signed_user_use_case.dart' as _i499;
import 'package:auth/src/use_cases/is_staff_user_use_case.dart' as _i461;
import 'package:auth/src/use_cases/remove_account_use_case.dart' as _i972;
import 'package:auth/src/use_cases/sign_out_use_case.dart' as _i643;
import 'package:auth/src/use_cases/upload_fcm_token_use_case.dart' as _i246;
import 'package:auth/src/use_cases/user_password_sign_in_use_case.dart'
    as _i608;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

class AuthPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final externalLibraries = _$ExternalLibraries();
    await gh.factoryAsync<_i116.GoogleSignIn>(
      () => externalLibraries.googleSignIn,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => externalLibraries.firebaseAuth);
    gh.lazySingleton<_i972.RemoveAccountUseCase>(
        () => _i972.RemoveAccountUseCase(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i499.HasSignedUserUseCase>(
        () => _i499.HasSignedUserUseCase(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i643.SignOutUseCase>(
        () => _i643.SignOutUseCase(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i1021.AppleSignInUseCase>(
        () => _i1021.AppleSignInUseCase(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i704.GetSignedUserUseCase>(
        () => _i704.GetSignedUserUseCase(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i461.IsStaffUserUseCase>(
        () => _i461.IsStaffUserUseCase(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i608.UserPasswordSignInUseCase>(
        () => _i608.UserPasswordSignInUseCase(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i184.AuthStateChangesUseCase>(
        () => _i184.AuthStateChangesUseCase(gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i173.CountUsersWithoutTShirtUseCase>(() =>
        _i173.CountUsersWithoutTShirtUseCase(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i714.CountUsersWithTShirtUseCase>(
        () => _i714.CountUsersWithTShirtUseCase(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i395.GoogleSignInUseCase>(() => _i395.GoogleSignInUseCase(
          gh<_i59.FirebaseAuth>(),
          gh<_i116.GoogleSignIn>(),
        ));
    gh.factory<_i299.SignInCubit>(() => _i299.SignInCubit(
          gh<_i608.UserPasswordSignInUseCase>(),
          gh<_i395.GoogleSignInUseCase>(),
          gh<_i1021.AppleSignInUseCase>(),
        ));
    gh.lazySingleton<_i491.GetSignedUserTeamUseCase>(
        () => _i491.GetSignedUserTeamUseCase(
              gh<_i974.FirebaseFirestore>(),
              gh<_i59.FirebaseAuth>(),
            ));
    gh.lazySingleton<_i246.UploadFcmTokenUseCase>(
        () => _i246.UploadFcmTokenUseCase(
              gh<_i974.FirebaseFirestore>(),
              gh<_i892.FirebaseMessaging>(),
              gh<_i662.GetSignedUserUseCase>(),
            ));
  }
}

class _$ExternalLibraries extends _i969.ExternalLibraries {}
