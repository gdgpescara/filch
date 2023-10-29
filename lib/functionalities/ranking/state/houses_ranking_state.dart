part of 'houses_ranking_cubit.dart';

sealed class HousesRankingState extends Equatable {
  const HousesRankingState(this.userHouse);

  final String? userHouse;
}

class HousesRankingLoading extends HousesRankingState {
  const HousesRankingLoading([super.userHouse]);

  @override
  List<Object?> get props => [userHouse];
}

class HousesRankingLoaded extends HousesRankingState {
  const HousesRankingLoaded(super.userHouse, {required this.houses});

  final List<House> houses;

  @override
  List<Object?> get props => [houses, userHouse];
}

class HousesRankingFailure extends HousesRankingState {
  const HousesRankingFailure(super.userHouse);

  @override
  List<Object?> get props => [userHouse];
}
