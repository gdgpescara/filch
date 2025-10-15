import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';
import 'package:rxdart/rxdart.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends SafeEmitterCubit<HomePageState> {
  HomePageCubit(
    this._isRankingFreezedUseCase,
    this._staffUserUseCase,
    this._sponsorUserUseCase,
    this._isBeforeDevFestUseCase,
  ) : super(const HomePageState());

  final IsBeforeDevFestUseCase _isBeforeDevFestUseCase;
  final IsRankingFreezedUseCase _isRankingFreezedUseCase;
  final IsStaffUserUseCase _staffUserUseCase;
  final IsSponsorUserUseCase _sponsorUserUseCase;
  StreamSubscription<void>? _subscription;

  void init() {
    _subscription?.cancel();
    _subscription =
        Rx.combineLatest4(
          _staffUserUseCase().asStream(),
          _sponsorUserUseCase().asStream(),
          _isRankingFreezedUseCase(),
          _isBeforeDevFestUseCase(),
          (staffResult, sponsorResult, isFreezedResult, isBeforeResult) => (staffResult, sponsorResult, isFreezedResult, isBeforeResult),
        ).when(
          progress: () => emit(state.copyWith(currentView: 0)),
          error: (_) => emit(state.copyWith(currentView: 0)),
          success: (data) {
            final (staffResult, sponsorResult, isFreezedResult, isBeforeResult) = data;
            emit(
              state.copyWith(
                staffUser: staffResult,
                sponsorUser: sponsorResult,
                isRankingFreezed: isFreezedResult,
                isBeforeDevFest: isBeforeResult,
              ),
            );
          },
        );
  }

  void changeView(int index) {
    emit(state.copyWith(currentView: index));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
