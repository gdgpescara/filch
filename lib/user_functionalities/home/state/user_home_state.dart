part of 'user_home_cubit.dart';

class UserHomeState extends Equatable {
  const UserHomeState([this.isRankingFreezed = false]);

  final bool isRankingFreezed;

  @override
  List<Object?> get props => [isRankingFreezed];
}
