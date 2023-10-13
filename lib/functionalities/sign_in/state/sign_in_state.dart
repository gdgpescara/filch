part of 'sign_in_cubit.dart';

sealed class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  const SignInLoading([this.provider]);

  final ProvidersEnum? provider;

  @override
  List<Object> get props => [];
}

class SignInSuccess extends SignInState {
  const SignInSuccess();

  @override
  List<Object> get props => [];
}

class SignInFailure extends SignInState {
  const SignInFailure(this.failure);

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
