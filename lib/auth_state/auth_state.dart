part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  const Authenticated();

  @override
  List<Object> get props => [];
}