part of 'bootstrap_cubit.dart';

sealed class BootstrapState extends Equatable {
  const BootstrapState();
}

class BootstrapProcessing extends BootstrapState {
  const BootstrapProcessing();

  @override
  List<Object> get props => [];
}

class UserLoggedOut extends BootstrapState {
  const UserLoggedOut();

  @override
  List<Object> get props => [];
}

class UserNeedSortingCeremony extends BootstrapState {
  const UserNeedSortingCeremony();

  @override
  List<Object> get props => [];
}

class AfterDevFest extends BootstrapState {
  const AfterDevFest();

  @override
  List<Object> get props => [];
}

class AppCanRun extends BootstrapState {
  const AppCanRun();

  @override
  List<Object> get props => [];
}
