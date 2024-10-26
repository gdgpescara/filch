part of 't_shirt_assignment_cubit.dart';

sealed class TShirtAssignmentState extends Equatable {
  const TShirtAssignmentState();

  @override
  List<Object?> get props => [];
}

final class TShirtAssignmentInitial extends TShirtAssignmentState {
  const TShirtAssignmentInitial();
}

final class TShirtAssigning extends TShirtAssignmentState {
  const TShirtAssigning();
}

final class TShirtAssignFailure extends TShirtAssignmentState {
  const TShirtAssignFailure();
}

final class TShirtAssigned extends TShirtAssignmentState {
  const TShirtAssigned();
}
