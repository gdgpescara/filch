part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.currentView = 1,
    this.isRankingFreezed = false,
    this.staffUser = false,
    this.sponsorUser = false,
  });

  final int currentView;
  final bool isRankingFreezed;
  final bool staffUser;
  final bool sponsorUser;

  HomePageState copyWith({
    int? currentView,
    bool? isRankingFreezed,
    bool? staffUser,
    bool? sponsorUser,
  }) {
    return HomePageState(
      currentView: currentView ?? this.currentView,
      isRankingFreezed: isRankingFreezed ?? this.isRankingFreezed,
      staffUser: staffUser ?? this.staffUser,
      sponsorUser: sponsorUser ?? this.sponsorUser,
    );
  }

  @override
  List<Object> get props => [currentView, isRankingFreezed, staffUser, sponsorUser];

  bool get showQuestPage => !isRankingFreezed && !staffUser && !sponsorUser;

  bool get showManagementView => staffUser || sponsorUser;

  bool get showShiftView => staffUser;
}
