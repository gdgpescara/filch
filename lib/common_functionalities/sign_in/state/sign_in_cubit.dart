import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../error_handling/failure.dart';
import '../../error_handling/future_extension.dart';
import '../models/providers_enum.dart';
import '../use_cases/apple_sign_in_use_case.dart';
import '../use_cases/facebook_sign_in_use_case.dart';
import '../use_cases/google_sign_in_use_case.dart';
import '../use_cases/twitter_sign_in_use_case.dart';
import '../use_cases/user_password_sign_in_use_case.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this._userPasswordSignInUseCase,
    this._googleSignInUseCase,
    this._facebookSignInUseCase,
    this._appleSignInUseCase,
    this._twitterSignInUseCase,
  ) : super(SignInWithProviders());

  final UserPasswordSignInUseCase _userPasswordSignInUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final FacebookSignInUseCase _facebookSignInUseCase;
  final AppleSignInUseCase _appleSignInUseCase;
  final TwitterSignInUseCase _twitterSignInUseCase;

  void emailPasswordSignIn(Map<String, Object?> formValue) {
    if (formValue['email'] is String && formValue['password'] is String) {
      _userPasswordSignInUseCase(formValue['email']! as String, formValue['password']! as String).actions(
        progress: () => _emitAction(const SignInLoading(ProvidersEnum.emailPassword)),
        success: (_) => _emitAction(const SignInSuccess()),
        failure: (e) => _emitAction(SignInFailure(e)),
      );
    }
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
      progress: () => _emitAction(const SignInLoading(ProvidersEnum.google)),
      success: (_) => _emitAction(const SignInSuccess()),
      failure: (e) => _emitAction(SignInFailure(e)),
    );
  }

  void _facebookSignIn() {
    _facebookSignInUseCase().actions(
      progress: () => _emitAction(const SignInLoading(ProvidersEnum.facebook)),
      success: (_) => _emitAction(const SignInSuccess()),
      failure: (e) => _emitAction(SignInFailure(e)),
    );
  }

  void _appleSignIn() {
    _appleSignInUseCase().actions(
      progress: () => _emitAction(const SignInLoading(ProvidersEnum.apple)),
      success: (_) => _emitAction(const SignInSuccess()),
      failure: (e) => _emitAction(SignInFailure(e)),
    );
  }

  void _twitterSignIn() {
    _twitterSignInUseCase().actions(
      progress: () => _emitAction(const SignInLoading(ProvidersEnum.twitter)),
      success: (_) => _emitAction(const SignInSuccess()),
      failure: (e) => _emitAction(SignInFailure(e)),
    );
  }

  void _emitAction(SignInActionsState action) {
    final current = state;
    emit(action);
    emit(current);
  }

  void switchSignIn() {
    if (state is SignInWithProviders) {
      emit(SignInWithUserPassword());
    } else {
      emit(SignInWithProviders());
    }
  }
}
