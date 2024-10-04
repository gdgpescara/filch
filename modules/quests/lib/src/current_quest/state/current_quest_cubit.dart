import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/active_quest.dart';
import '../../use_cases/can_request_for_quest_use_case.dart';
import '../../use_cases/get_signed_user_active_quest_use_case.dart';
import '../../use_cases/give_up_quest_use_case.dart';
import '../../use_cases/search_for_quest_use_case.dart';

part 'current_quest_state.dart';

@injectable
class CurrentQuestCubit extends SafeEmitterCubit<CurrentQuestState> {
  CurrentQuestCubit(
    this._getSignedUserUseCase,
    this._getSignedUserActiveQuestUseCase,
    this._searchForQuestUseCase,
    this._canRequestForQuestUseCase,
    this._giveUpQuestUseCase,
  ) : super(const CurrentQuestLoading());

  final GetSignedUserUseCase _getSignedUserUseCase;
  final GetSignedUserActiveQuestUseCase _getSignedUserActiveQuestUseCase;
  final SearchForQuestUseCase _searchForQuestUseCase;
  final CanRequestForQuestUseCase _canRequestForQuestUseCase;
  final GiveUpQuestUseCase _giveUpQuestUseCase;

  void loadCurrentQuest() {
    _getSignedUserActiveQuestUseCase().when(
      progress: () => emit(const CurrentQuestLoading()),
      success: (quest) {
        if (quest != null) {
          final user = _getSignedUserUseCase();
          emit(CurrentQuestLoaded(user: user, activeQuest: quest));
        } else {
          _canRequestForQuest();
        }
      },
      failure: (_) => emit(const CurrentQuestFailure()),
    );
  }

  void timeExpired() {
    _canRequestForQuest();
  }

  void giveUp() {
    _giveUpQuestUseCase().when(
      progress: () => emit(const CurrentQuestLoading()),
      success: (_) => emit(const NoQuestAssigned()),
      failure: (_) => emit(const CurrentQuestFailure()),
    );
  }

  Future<void> _canRequestForQuest() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    _canRequestForQuestUseCase().when(
      progress: () => emit(const CurrentQuestLoading()),
      success: (canRequest) => canRequest ? emit(const NoQuestAssigned()) : emit(const QuestRequestClosed()),
      failure: (_) => emit(const CurrentQuestFailure()),
    );
  }

  void searchForQuest() {
    _searchForQuestUseCase().when(
      progress: () => emit(const CurrentQuestLoading()),
      success: (quest) => emit(CurrentQuestLoaded(activeQuest: quest)),
      failure: (_) => emit(const CurrentQuestFailure()),
    );
  }
}
