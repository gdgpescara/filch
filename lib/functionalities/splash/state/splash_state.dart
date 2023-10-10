part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();
}

class SplashLoading extends SplashState {
  @override
  List<Object> get props => [];
}

class UserLoggedOut extends SplashState {
  const UserLoggedOut();

  @override
  List<Object> get props => [];
}

class UserNeedSortingCeremony extends SplashState {
  const UserNeedSortingCeremony();

  @override
  List<Object> get props => [];
}

class AppCanRun extends SplashState {
  const AppCanRun();

  @override
  List<Object> get props => [];
}
