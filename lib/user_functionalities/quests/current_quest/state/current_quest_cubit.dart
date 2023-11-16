import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../common_functionalities/error_handling/future_extension.dart';
import '../../../../common_functionalities/error_handling/stream_extension.dart';
import '../../../../common_functionalities/state/safe_emitter_cubit.dart';
import '../../../../common_functionalities/user/use_cases/get_signed_user_active_quest_use_case.dart';
import '../../models/active_quest.dart';
import '../../use_cases/can_request_for_quest_use_case.dart';
import '../../use_cases/give_up_quest_use_case.dart';
import '../../use_cases/search_for_quest_use_case.dart';

part 'current_quest_state.dart';

@injectable
class CurrentQuestCubit extends SafeEmitterCubit<CurrentQuestState> {
  CurrentQuestCubit(
    this._getSignedUserActiveQuestUseCase,
    this._searchForQuestUseCase,
    this._canRequestForQuestUseCase,
    this._giveUpQuestUseCase,
  ) : super(const CurrentQuestLoading());

  final GetSignedUserActiveQuestUseCase _getSignedUserActiveQuestUseCase;
  final SearchForQuestUseCase _searchForQuestUseCase;
  final CanRequestForQuestUseCase _canRequestForQuestUseCase;
  final GiveUpQuestUseCase _giveUpQuestUseCase;

  void loadCurrentQuest() {
    _getSignedUserActiveQuestUseCase().actions(
      progress: () => emit(const CurrentQuestLoading()),
      success: (quest) => quest == null ? _canRequestForQuest() : emit(CurrentQuestLoaded(activeQuest: quest)),
      failure: (_) => emit(const CurrentQuestFailure()),
    );
  }

  void timeExpired() {
    _canRequestForQuest();
  }

  void giveUp() {
    _giveUpQuestUseCase().actions(
      progress: () => emit(const CurrentQuestLoading()),
      success: (_) => emit(const NoQuestAssigned()),
      failure: (_) => emit(const CurrentQuestFailure()),
    );
  }

  Future<void> _canRequestForQuest() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _canRequestForQuestUseCase().actions(
      progress: () => emit(const CurrentQuestLoading()),
      success: (canRequest) => canRequest ? emit(const NoQuestAssigned()) : emit(const QuestRequestClosed()),
      failure: (_) => emit(const CurrentQuestFailure()),
    );
  }

  void searchForQuest() {
    _searchForQuestUseCase().actions(
      progress: () => emit(const CurrentQuestLoading()),
      success: (quest) => emit(CurrentQuestLoaded(activeQuest: quest)),
      failure: (_) => emit(const CurrentQuestFailure()),
    );
  }
}
