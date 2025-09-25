import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:schedule/schedule.dart';

part 'schedule_delay_state.dart';

@injectable
class ScheduleDelayCubit extends Cubit<ScheduleDelayState> {
  ScheduleDelayCubit(
    this._getRoomsUseCase,
  ) : super(const ScheduleDelayLoading());

  final GetRoomsUseCase _getRoomsUseCase;

  StreamSubscription<List<NamedEntity>>? _roomsSubscription;

  Future<void> init() async {
    await _roomsSubscription?.cancel();
    _roomsSubscription = _getRoomsUseCase().when(
      progress: () => emit(const ScheduleDelayLoading()),
      success: (rooms) => emit(ScheduleDelayLoaded(rooms)),
      error: (error) => emit(ScheduleDelayFailure(error.toString())),
    );
  }
}
