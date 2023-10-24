import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../_shared/error_handling/future_extension.dart';
import '../../../../user/use_cases/get_signed_user_archived_quests_use_case.dart';
import '../../../models/archived_quest.dart';

part 'personal_archived_quests_state.dart';

@injectable
class PersonalArchivedQuestsCubit extends Cubit<PersonalArchivedQuestsState> {
  PersonalArchivedQuestsCubit(this._getSignedUserArchivedQuestsUseCase) : super(const PersonalArchivedQuestsLoading());

  final GetSignedUserArchivedQuestsUseCase _getSignedUserArchivedQuestsUseCase;

  Future<void> loadArchivedQuests() async {
    _getSignedUserArchivedQuestsUseCase().actions(
      progress: () => emit(const PersonalArchivedQuestsLoading()),
      success: (archivedQuests) => emit(PersonalArchivedQuestsLoaded(archivedQuests: archivedQuests)),
      failure: (e) => emit(const PersonalArchivedQuestsFailure()),
    );
  }
}
