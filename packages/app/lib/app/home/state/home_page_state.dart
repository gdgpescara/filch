part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.currentView = 1,
    this.isRankingFreezed = false,
    this.isStaffUser = false,
  });

  final int currentView;
  final bool isRankingFreezed;
  final bool isStaffUser;

  HomePageState copyWith({
    int? currentView,
    bool? isRankingFreezed,
    bool? isStaffUser,
  }) {
    return HomePageState(
      currentView: currentView ?? this.currentView,
      isRankingFreezed: isRankingFreezed ?? this.isRankingFreezed,
      isStaffUser: isStaffUser ?? this.isStaffUser,
    );
  }

  @override
  List<Object> get props => [currentView, isRankingFreezed, isStaffUser];
}
