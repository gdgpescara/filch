part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.currentView = 1,
    this.isRankingFreezed = false,
    this.staffUser = false,
    this.sponsorUser = false,
    this.isBeforeDevFest = true,
  });

  final int currentView;
  final bool isRankingFreezed;
  final bool staffUser;
  final bool sponsorUser;
  final bool isBeforeDevFest;

  HomePageState copyWith({
    int? currentView,
    bool? isRankingFreezed,
    bool? staffUser,
    bool? sponsorUser,
    bool? isBeforeDevFest,
  }) {
    return HomePageState(
      currentView: currentView ?? this.currentView,
      isRankingFreezed: isRankingFreezed ?? this.isRankingFreezed,
      staffUser: staffUser ?? this.staffUser,
      sponsorUser: sponsorUser ?? this.sponsorUser,
      isBeforeDevFest: isBeforeDevFest ?? this.isBeforeDevFest,
    );
  }

  @override
  List<Object> get props => [currentView, isRankingFreezed, staffUser, sponsorUser, isBeforeDevFest];

  bool get showQuestPage => !isRankingFreezed && !staffUser && !sponsorUser && !isBeforeDevFest;

  bool get showManagementView => staffUser || sponsorUser;

  bool get showShiftView => staffUser;
}
