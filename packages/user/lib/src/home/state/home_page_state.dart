part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({this.currentView = 1, this.isRankingFreezed = false});

  final int currentView;
  final bool isRankingFreezed;

  HomePageState copyWith({int? currentView, bool? isRankingFreezed}) {
    return HomePageState(
      currentView: currentView ?? this.currentView,
      isRankingFreezed: isRankingFreezed ?? this.isRankingFreezed,
    );
  }

  @override
  List<Object> get props => [currentView, isRankingFreezed];
}
