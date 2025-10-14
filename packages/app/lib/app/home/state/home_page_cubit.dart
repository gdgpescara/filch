import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends SafeEmitterCubit<HomePageState> {
  HomePageCubit(this._isRankingFreezedUseCase, this._staffUserUseCase, this._sponsorUserUseCase) : super(const HomePageState());

  final IsRankingFreezedUseCase _isRankingFreezedUseCase;
  final IsStaffUserUseCase _staffUserUseCase;
  final IsSponsorUserUseCase _sponsorUserUseCase;
  StreamSubscription<void>? _subscription;

  void init() {
    _subscription?.cancel();
    _staffUserUseCase().when(
      progress: () => emit(const HomePageState()),
      success: (staff) => emit(state.copyWith(staffUser: staff)),
      error: (_) => emit(const HomePageState()),
    );
    _sponsorUserUseCase().when(
      progress: () => emit(const HomePageState()),
      success: (sponsor) => emit(state.copyWith(sponsorUser: sponsor)),
      error: (_) => emit(const HomePageState()),
    );
    _subscription = _isRankingFreezedUseCase().when(
      progress: () => emit(const HomePageState()),
      success: (isFreezed) => emit(state.copyWith(isRankingFreezed: isFreezed, currentView: 0)),
      error: (_) => emit(const HomePageState()),
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
