part of 'user_t_shirt_cubit.dart';

sealed class UserTShirtState extends Equatable {
  const UserTShirtState();

  @override
  List<Object?> get props => [];
}

final class UserTShirtLoading extends UserTShirtState {
  const UserTShirtLoading();
}

final class UserTShirtLoaded extends UserTShirtState {
  const UserTShirtLoaded({this.status = TShirtPickUpState.none});

  final TShirtPickUpState status;

  @override
  List<Object?> get props => [status];
}

final class UserTShirtFailure extends UserTShirtState {
  const UserTShirtFailure();
}
