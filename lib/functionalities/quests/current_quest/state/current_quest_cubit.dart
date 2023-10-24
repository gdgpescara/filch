import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../_shared/error_handling/future_extension.dart';
import '../../../user/use_cases/get_signed_user_active_quest_use_case.dart';
import '../../models/active_quest.dart';
import '../use_cases/search_for_quest_use_case.dart';

part 'current_quest_state.dart';

@injectable
class CurrentQuestCubit extends Cubit<CurrentQuestState> {
  CurrentQuestCubit(
    this._getSignedUserActiveQuestUseCase,
    this._searchForQuestUseCase,
  ) : super(const CurrentQuestLoading());

  final GetSignedUserActiveQuestUseCase _getSignedUserActiveQuestUseCase;
  final SearchForQuestUseCase _searchForQuestUseCase;

  void loadCurrentQuest() {
    _getSignedUserActiveQuestUseCase().actions(
      progress: () => emit(const CurrentQuestLoading()),
      success: (quest) => quest == null ? emit(const NoQuestAssigned()) : emit(CurrentQuestLoaded(activeQuest: quest)),
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
