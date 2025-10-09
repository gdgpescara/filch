part of 'assignment_cubit.dart';

sealed class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object?> get props => [];
}

class AssignmentInitial extends AssignmentState {
  const AssignmentInitial([this.scannedUsers = const []]);

  final List<String> scannedUsers;

  @override
  List<Object?> get props => [scannedUsers];
}

class Assigning extends AssignmentState {
  const Assigning();
}

class AssignFailure extends AssignmentState {
  const AssignFailure({required this.code});

  final String code;

  @override
  List<Object?> get props => [code];
}

class Assigned extends AssignmentState {
  const Assigned();
}
