part of 'ranking_cubit.dart';

sealed class RankingState extends Equatable {
  const RankingState();
}

class RankingFreezed extends RankingState {
  const RankingFreezed();

  @override
  List<Object?> get props => [];
}

class RankingLoading extends RankingState {
  const RankingLoading();

  @override
  List<Object?> get props => [];
}

class RankingLoaded extends RankingState {
  const RankingLoaded({required this.items, required this.userUid});

  final List<RankingItem> items;
  final String userUid;

  @override
  List<Object?> get props => [items, userUid];
}

class RankingFailure extends RankingState {
 const RankingFailure();

  @override
  List<Object?> get props => [];
}

sealed class YourRankingState extends RankingState {
  const YourRankingState();
}

class YourRankingLoading extends YourRankingState {
  const YourRankingLoading();

  @override
  List<Object?> get props => [];
}

class YourRankingNotInRanking extends YourRankingState {
  const YourRankingNotInRanking();

  @override
  List<Object?> get props => [];
}

class YourRankingLoaded extends YourRankingState {
  const YourRankingLoaded({required this.item, required this.position});

  final RankingItem item;
  final int position;

  @override
  List<Object?> get props => [item, position];
}

class YourRankingFailure extends YourRankingState {
  const YourRankingFailure();

  @override
  List<Object?> get props => [];
}