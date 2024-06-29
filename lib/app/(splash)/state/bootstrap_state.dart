part of 'bootstrap_cubit.dart';

sealed class BootstrapState extends Equatable {
  const BootstrapState();
}

final class BootstrapInitial extends BootstrapState {
  const BootstrapInitial();

  @override
  List<Object> get props => [];
}

final class BootstrapDone extends BootstrapState {
  const BootstrapDone();

  @override
  List<Object> get props => [];
}
