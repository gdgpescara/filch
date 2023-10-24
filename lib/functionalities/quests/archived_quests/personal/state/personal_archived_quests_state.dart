part of 'personal_archived_quests_cubit.dart';

sealed class PersonalArchivedQuestsState extends Equatable {
  const PersonalArchivedQuestsState();
}

class PersonalArchivedQuestsLoading extends PersonalArchivedQuestsState {
  const PersonalArchivedQuestsLoading();

  @override
  List<Object> get props => [];
}

class PersonalArchivedQuestsLoaded extends PersonalArchivedQuestsState {
  const PersonalArchivedQuestsLoaded({required this.archivedQuests});

  final List<ArchivedQuest> archivedQuests;

  @override
  List<Object> get props => [archivedQuests];
}

class PersonalArchivedQuestsFailure extends PersonalArchivedQuestsState {
  const PersonalArchivedQuestsFailure();

  @override
  List<Object> get props => [];
}
