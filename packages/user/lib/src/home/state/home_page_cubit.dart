import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends SafeEmitterCubit<HomePageState> {
  HomePageCubit(this._isRankingFreezedUseCase) : super(const HomePageState());

  final IsRankingFreezedUseCase _isRankingFreezedUseCase;
  StreamSubscription<void>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void checkRankingFreezed() {
    _subscription = _isRankingFreezedUseCase().when(
      progress: () => emit(const HomePageState()),
      success: (isFreezed) => emit(state.copyWith(isRankingFreezed: isFreezed, currentView: 0)),
      error: (_) => emit(const HomePageState()),
    );
  }

  void changeView(int index) {
    emit(state.copyWith(currentView: index));
  }
}
