import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';

part 't_shirt_assignment_state.dart';

@injectable
class TShirtAssignmentCubit extends Cubit<TShirtAssignmentState> {
  TShirtAssignmentCubit(
    this._assignTShirtUseCase,
  ) : super(const TShirtAssignmentInitial());

  final AssignTShirtUseCase _assignTShirtUseCase;

  Future<void> assignTShirt(String user) async {
    await _assignTShirtUseCase(user).when(
      progress: () => emit(const TShirtAssigning()),
      failure: (_) => emit(const TShirtAssignFailure()),
      success: (_) => emit(const TShirtAssigned()),
    );
  }
}
