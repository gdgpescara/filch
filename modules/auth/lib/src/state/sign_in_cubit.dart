import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../models/providers_enum.dart';
import '../use_cases/apple_sign_in_use_case.dart';
import '../use_cases/google_sign_in_use_case.dart';
import '../use_cases/user_password_sign_in_use_case.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends SafeEmitterCubit<SignInState> {
  SignInCubit(
    this._userPasswordSignInUseCase,
    this._googleSignInUseCase,
    this._appleSignInUseCase,
  ) : super(SignInWithProviders());

  final UserPasswordSignInUseCase _userPasswordSignInUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final AppleSignInUseCase _appleSignInUseCase;

  void emailPasswordSignIn(Map<String, Object?> formValue) {
    if (formValue['email'] is String && formValue['password'] is String) {
      _userPasswordSignInUseCase(formValue['email']! as String, formValue['password']! as String).when(
        progress: () => _emitAction(const SignInLoading(ProvidersEnum.emailPassword)),
        success: (_) => _emitAction(const SignInSuccess()),
        failure: (e) => _emitAction(SignInFailure(failure: e)),
      );
    }
  }

  void providerSignIn(ProvidersEnum provider) {
    <ProvidersEnum, VoidCallback>{
      ProvidersEnum.google: _googleSignIn,
      ProvidersEnum.apple: _appleSignIn,
    }[provider]!
        .call();
  }

  void _googleSignIn() {
    _googleSignInUseCase().when(
      progress: () => _emitAction(const SignInLoading(ProvidersEnum.google)),
      success: (_) => _emitAction(const SignInSuccess()),
      failure: (e) => _emitAction(SignInFailure(failure: e)),
    );
  }

  void _appleSignIn() {
    _appleSignInUseCase().when(
      progress: () => _emitAction(const SignInLoading(ProvidersEnum.apple)),
      success: (_) => _emitAction(const SignInSuccess()),
      failure: (e) => _emitAction(SignInFailure(failure: e)),
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
