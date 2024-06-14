//@GeneratedMicroModule;AuthPackageModule;package:auth/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:auth/src/di/external_libraries.dart' as _i13;
import 'package:auth/src/state/sign_in_cubit.dart' as _i12;
import 'package:auth/src/use_cases/apple_sign_in_use_case.dart' as _i7;
import 'package:auth/src/use_cases/auth_state_changes_use_case.dart' as _i11;
import 'package:auth/src/use_cases/google_sign_in_use_case.dart' as _i8;
import 'package:auth/src/use_cases/has_signed_user_use_case.dart' as _i5;
import 'package:auth/src/use_cases/is_staff_user_use_case.dart' as _i9;
import 'package:auth/src/use_cases/remove_account_use_case.dart' as _i4;
import 'package:auth/src/use_cases/sign_out_use_case.dart' as _i6;
import 'package:auth/src/use_cases/user_password_sign_in_use_case.dart' as _i10;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:injectable/injectable.dart' as _i1;

class AuthPackageModule extends _i1.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i2.FutureOr<void> init(_i1.GetItHelper gh) {
    final externalLibraries = _$ExternalLibraries();
    gh.lazySingleton<_i3.FirebaseAuth>(() => externalLibraries.firebaseAuth);
    gh.lazySingleton<_i4.RemoveAccountUseCase>(
        () => _i4.RemoveAccountUseCase(gh<_i3.FirebaseAuth>()));
    gh.lazySingleton<_i5.HasSignedUserUseCase>(
        () => _i5.HasSignedUserUseCase(gh<_i3.FirebaseAuth>()));
    gh.lazySingleton<_i6.SignOutUseCase>(
        () => _i6.SignOutUseCase(gh<_i3.FirebaseAuth>()));
    gh.lazySingleton<_i7.AppleSignInUseCase>(
        () => _i7.AppleSignInUseCase(gh<_i3.FirebaseAuth>()));
    gh.lazySingleton<_i8.GoogleSignInUseCase>(
        () => _i8.GoogleSignInUseCase(gh<_i3.FirebaseAuth>()));
    gh.lazySingleton<_i9.IsStaffUserUseCase>(
        () => _i9.IsStaffUserUseCase(gh<_i3.FirebaseAuth>()));
    gh.lazySingleton<_i10.UserPasswordSignInUseCase>(
        () => _i10.UserPasswordSignInUseCase(gh<_i3.FirebaseAuth>()));
    gh.lazySingleton<_i11.AuthStateChangesUseCase>(
        () => _i11.AuthStateChangesUseCase(gh<_i3.FirebaseAuth>()));
    gh.factory<_i12.SignInCubit>(() => _i12.SignInCubit(
          gh<_i10.UserPasswordSignInUseCase>(),
          gh<_i8.GoogleSignInUseCase>(),
          gh<_i7.AppleSignInUseCase>(),
        ));
  }
}

class _$ExternalLibraries extends _i13.ExternalLibraries {}
