import 'dart:async';

import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../models/grouped_sessions.dart';
import '../../../use_cases/get_grouped_sessions_use_case.dart';
import 'schedule_state.dart';

@injectable
class ScheduleCubit extends SafeEmitterCubit<ScheduleState> {
  ScheduleCubit(
    this._getGroupedSessionsUseCase,
  ) : super(const ScheduleInitial());

  final GetGroupedSessionsUseCase _getGroupedSessionsUseCase;

  StreamSubscription<GroupedSessions>? _sessionsSubscription;

  void init() {
    _sessionsSubscription?.cancel();
    _sessionsSubscription = _getGroupedSessionsUseCase().when(
      progress: () => emit(const ScheduleLoading()),
      success: (groupedSessions) => emit(ScheduleLoaded(groupedSessions: groupedSessions)),
      error: (error) => emit(ScheduleError(message: error.message)),
    );
  }

  @override
  Future<void> close() {
    _sessionsSubscription?.cancel();
    return super.close();
  }
}
