import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../use_cases/has_user_picked_t_shirt_use_case.dart';

part 'user_t_shirt_state.dart';

@injectable
class UserTShirtCubit extends Cubit<UserTShirtState> {
  UserTShirtCubit(
    this._hasUserPickedTShirtUseCase,
  ) : super(const UserTShirtLoading());

  final HasUserPickedTShirtUseCase _hasUserPickedTShirtUseCase;

  void checkTShirt() {
    _hasUserPickedTShirtUseCase().when(
      progress: () => emit(const UserTShirtLoading()),
      success: (value) => emit(UserTShirtLoaded(hasUserPickedTShirt: value)),
      failure: (_) => emit(const UserTShirtFailure()),
    );
  }
}
