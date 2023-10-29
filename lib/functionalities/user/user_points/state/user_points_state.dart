part of 'user_points_cubit.dart';

sealed class UserPointsState extends Equatable {
  const UserPointsState();
}

class UserPointsLoading extends UserPointsState {
  const UserPointsLoading();

  @override
  List<Object> get props => [];
}

class UserPointsLoaded extends UserPointsState {
  const UserPointsLoaded(this.points);

  final List<Points> points;

  int get totals => points.fold<int>(0, (previousValue, element) => previousValue + element.points);

  @override
  List<Object> get props => [points];
}

class UserPointsFailure extends UserPointsState {
  const UserPointsFailure();

  @override
  List<Object> get props => [];
}
