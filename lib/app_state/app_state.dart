part of 'app_cubit.dart';

sealed class AppState extends Equatable {
  const AppState();
}

class AppUnauthenticated extends AppState {
  const AppUnauthenticated();

  @override
  List<Object> get props => [];
}

class AppAuthenticated extends AppState {
  const AppAuthenticated();

  @override
  List<Object> get props => [];
}
