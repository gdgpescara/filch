part of 'winner_house_cubit.dart';

sealed class WinnerHouseState extends Equatable {
  const WinnerHouseState();
}

class WinnerHouseLoading extends WinnerHouseState {
  const WinnerHouseLoading();

  @override
  List<Object> get props => [];
}

class WinnerHouseLoaded extends WinnerHouseState {
  const WinnerHouseLoaded({required this.house});

  final HouseDetail house;

  @override
  List<Object> get props => [house];
}

class WinnerHouseFailure extends WinnerHouseState {
  const WinnerHouseFailure();

  @override
  List<Object> get props => [];
}
