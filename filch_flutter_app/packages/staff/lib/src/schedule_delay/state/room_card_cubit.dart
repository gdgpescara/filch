import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:schedule/schedule.dart';

part 'room_card_state.dart';

@injectable
class RoomCardCubit extends Cubit<RoomCardState> {
  RoomCardCubit(
    this.room,
    this._getRoomDelayUseCase,
    this._registerRoomDelayUseCase,
  ) : super(const RoomCardInitial()) {
    init();
  }

  final NamedEntity room;
  final GetRoomDelayUseCase _getRoomDelayUseCase;
  final RegisterRoomDelayUseCase _registerRoomDelayUseCase;

  StreamSubscription<RoomDelay?>? _delaySubscription;

  Future<void> init() async {
    await _delaySubscription?.cancel();
    _delaySubscription = _getRoomDelayUseCase(room.id.toString()).when(
      progress: () => emit(const RoomCardInitial()),
      success: (roomDelay) {
        final delay = roomDelay?.delay ?? 0;
        emit(RoomCardLoaded(delay, delay));
      },
      error: (_) => emit(const RoomCardError()),
    );
  }

  void updateDelayValue(int newDelay) {
    final clamped = newDelay.clamp(0, double.infinity).toInt();
    final currentState = state;
    if (currentState is RoomCardLoaded) {
      emit(RoomCardLoaded(clamped, currentState.originalDelay));
    }
  }

  void sendDelay() {
    if (state case final RoomCardLoaded currentState) {
      final delayDifference = currentState.delay - currentState.originalDelay;
      _registerRoomDelayUseCase(room.id.toString(), delayDifference).when(
        progress: () => emit(RoomCardDelaySending(currentState.delay, currentState.originalDelay)),
        success: (_) => init(),
        error: (_) => emit(RoomCardDelaySendError(currentState.delay, currentState.originalDelay)),
      );
    }
  }

  @override
  Future<void> close() {
    _delaySubscription?.cancel();
    return super.close();
  }
}
