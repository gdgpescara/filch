import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../_shared/error_handling/failure.dart';
import '../../_shared/error_handling/future_extension.dart';
import '../domain/models/providers_enum.dart';
import '../domain/use_cases/apple_sign_in_use_case.dart';
import '../domain/use_cases/facebook_sign_in_use_case.dart';
import '../domain/use_cases/google_sign_in_use_case.dart';
import '../domain/use_cases/twitter_sign_in_use_case.dart';
import '../domain/use_cases/user_password_sign_in_use_case.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this._userPasswordSignInUseCase,
    this._googleSignInUseCase,
    this._facebookSignInUseCase,
    this._appleSignInUseCase,
    this._twitterSignInUseCase,
  ) : super(SignInInitial());

  final UserPasswordSignInUseCase _userPasswordSignInUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final FacebookSignInUseCase _facebookSignInUseCase;
  final AppleSignInUseCase _appleSignInUseCase;
  final TwitterSignInUseCase _twitterSignInUseCase;

  void emailPasswordSignIn(Map<String, String> formValue) {
    _userPasswordSignInUseCase(formValue['email']!, formValue['password']!).actions(
      progress: () => emit(const SignInLoading()),
      success: (_) => emit(const SignInSuccess()),
      failure: (e) => emit(SignInFailure(e)),
    );
  }

  void providerSignIn(ProvidersEnum provider) {
    <ProvidersEnum, VoidCallback>{
      ProvidersEnum.google: _googleSignIn,
      ProvidersEnum.facebook: _facebookSignIn,
      ProvidersEnum.apple: _appleSignIn,
      ProvidersEnum.twitter: _twitterSignIn,
    }[provider]!
        .call();
  }

  void _googleSignIn() {
    _googleSignInUseCase().actions(
      progress: () => emit(const SignInLoading(ProvidersEnum.google)),
      success: (_) => emit(const SignInSuccess()),
      failure: (e) => emit(SignInFailure(e)),
    );
  }

  void _facebookSignIn() {
    _facebookSignInUseCase().actions(
      progress: () => emit(const SignInLoading(ProvidersEnum.facebook)),
      success: (_) => emit(const SignInSuccess()),
      failure: (e) => emit(SignInFailure(e)),
    );
  }

  void _appleSignIn() {
    _appleSignInUseCase().actions(
      progress: () => emit(const SignInLoading(ProvidersEnum.apple)),
      success: (_) => emit(const SignInSuccess()),
      failure: (e) => emit(SignInFailure(e)),
    );
  }

  void _twitterSignIn() {
    _twitterSignInUseCase().actions(
      progress: () => emit(const SignInLoading(ProvidersEnum.twitter)),
      success: (_) => emit(const SignInSuccess()),
      failure: (e) => emit(SignInFailure(e)),
    );
  }
}
