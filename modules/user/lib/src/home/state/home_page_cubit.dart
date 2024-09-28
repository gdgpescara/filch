import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends SafeEmitterCubit<HomePageState> {
  HomePageCubit(this._isRankingFreezedUseCase) : super(const HomePageState());

  final IsRankingFreezedUseCase _isRankingFreezedUseCase;

  void checkRankingFreezed() {
    _isRankingFreezedUseCase().when(
      progress: () => emit(const HomePageState()),
      success: (isFreezed) => emit(state.copyWith(isRankingFreezed: isFreezed, currentView: isFreezed ? 0 : 1)),
      failure: (_) => emit(const HomePageState()),
    );
  }

  void changeView(int index) {
    emit(state.copyWith(currentView: index));
  }
}
