part of 'current_quest_cubit.dart';

sealed class CurrentQuestState extends Equatable {
  const CurrentQuestState();
}

class CurrentQuestLoading extends CurrentQuestState {
  const CurrentQuestLoading();

  @override
  List<Object> get props => [];
}

class NoQuestAssigned extends CurrentQuestState {
  const NoQuestAssigned();

  @override
  List<Object> get props => [];
}

class QuestRequestClosed extends CurrentQuestState {
  const QuestRequestClosed();

  @override
  List<Object> get props => [];
}

class CurrentQuestLoaded extends CurrentQuestState {
  const CurrentQuestLoaded({required this.activeQuest});

  final ActiveQuest activeQuest;

  @override
  List<Object> get props => [activeQuest];
}

class CurrentQuestFailure extends CurrentQuestState {
  const CurrentQuestFailure();

  @override
  List<Object> get props => [];
}
