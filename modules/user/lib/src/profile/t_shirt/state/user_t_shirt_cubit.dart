import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../models/t_shirt_pick_up_state.dart';
import '../../../use_cases/t_shirt_pick_up_state_use_case.dart';

part 'user_t_shirt_state.dart';

@injectable
class UserTShirtCubit extends SafeEmitterCubit<UserTShirtState> {
  UserTShirtCubit(this._tShirtPickUpStateUseCase) : super(const UserTShirtLoading());

  final TShirtPickUpStateUseCase _tShirtPickUpStateUseCase;

  StreamSubscription<void>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void checkTShirt() {
    _subscription = _tShirtPickUpStateUseCase().when(
      progress: () => emit(const UserTShirtLoading()),
      success: (value) => emit(UserTShirtLoaded(status: value)),
      error: (_) => emit(const UserTShirtFailure()),
    );
  }
}
