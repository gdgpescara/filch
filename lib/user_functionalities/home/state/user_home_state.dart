part of 'user_home_cubit.dart';

class UserHomeState extends Equatable {
  const UserHomeState([this.isRankingFreezed = false, this.currentView = 1]);

  final bool isRankingFreezed;
  final int currentView;

  @override
  List<Object?> get props => [isRankingFreezed, currentView];
}
