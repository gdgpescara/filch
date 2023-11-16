import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../common_functionalities/error_handling/stream_extension.dart';
import '../../../common_functionalities/state/safe_emitter_cubit.dart';
import '../../quests/use_cases/is_ranking_freezed_use_case.dart';

part 'user_home_state.dart';

@injectable
class UserHomeCubit extends SafeEmitterCubit<UserHomeState> {
  UserHomeCubit(this._isRankingFreezedUseCase) : super(const UserHomeState());

  final IsRankingFreezedUseCase _isRankingFreezedUseCase;

  void checkRankingFreezed() {
    _isRankingFreezedUseCase().actions(
      progress: () => emit(const UserHomeState()),
      success: (isFreezed) => emit(UserHomeState(isFreezed, isFreezed ? 0 : state.currentView)),
      failure: (_) => emit(const UserHomeState()),
    );
  }

  void changeView(int index) {
    emit(UserHomeState(state.isRankingFreezed, index));
  }
}
