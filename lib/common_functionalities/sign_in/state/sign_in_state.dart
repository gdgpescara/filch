part of 'sign_in_cubit.dart';

sealed class SignInState extends Equatable {
  const SignInState();
}

class SignInWithProviders extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInWithUserPassword extends SignInState {
  @override
  List<Object> get props => [];
}

sealed class SignInActionsState extends SignInState {
  const SignInActionsState();

  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInActionsState {
  const SignInLoading([this.provider]);

  final ProvidersEnum? provider;

  @override
  List<Object> get props => [];
}

class SignInSuccess extends SignInActionsState {
  const SignInSuccess();

  @override
  List<Object> get props => [];
}

class SignInFailure extends SignInActionsState {
  const SignInFailure({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
