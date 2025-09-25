import 'dart:async';

import 'package:bloc/bloc.dart';
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
    _delaySubscription = _getRoomDelayUseCase(room.id.toString()).listen((roomDelay) {
      final delay = roomDelay?.minutes ?? 0;
      emit(RoomCardLoaded(delay, delay));
    });
  }

  void updateDelay(int newDelay) {
    final clamped = newDelay.clamp(0, double.infinity).toInt();
    final currentState = state;
    if (currentState is RoomCardLoaded) {
      emit(RoomCardLoaded(clamped, currentState.originalDelay));
    }
  }

  Future<void> sendDelay() async {
    final currentState = state;
    if (currentState is RoomCardLoaded) {
      await _registerRoomDelayUseCase(room.id.toString(), currentState.delay);
    }
  }

  @override
  Future<void> close() {
    _delaySubscription?.cancel();
    return super.close();
  }
}
