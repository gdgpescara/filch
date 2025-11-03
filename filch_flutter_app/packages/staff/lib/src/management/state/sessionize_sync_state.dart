part of 'sessionize_sync_cubit.dart';

sealed class SessionizeSyncState extends Equatable {
  const SessionizeSyncState();
}

final class SessionizeSyncInitial extends SessionizeSyncState {
  @override
  List<Object> get props => [];
}

final class SessionizeSyncInProgress extends SessionizeSyncState {
  @override
  List<Object> get props => [];
}

final class SessionizeSyncSuccess extends SessionizeSyncState {
  @override
  List<Object> get props => [];
}

final class SessionizeSyncFailure extends SessionizeSyncState {
  const SessionizeSyncFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
