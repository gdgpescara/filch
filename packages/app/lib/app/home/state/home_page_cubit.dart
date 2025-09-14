import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends SafeEmitterCubit<HomePageState> {
  HomePageCubit(this._isRankingFreezedUseCase, this._isStaffUserUseCase) : super(const HomePageState());

  final IsRankingFreezedUseCase _isRankingFreezedUseCase;
  final IsStaffUserUseCase _isStaffUserUseCase;
  StreamSubscription<void>? _subscription;

  void init() {
    _subscription?.cancel();
    _isStaffUserUseCase().when(
      progress: () => emit(const HomePageState()),
      success: (isStaff) => emit(state.copyWith(isStaffUser: isStaff)),
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
