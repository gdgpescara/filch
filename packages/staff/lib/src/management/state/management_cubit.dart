import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:quests/quests.dart';
import 'package:rxdart/rxdart.dart';
import 'package:schedule/schedule.dart';

part 'management_state.dart';

@injectable
class ManagementCubit extends SafeEmitterCubit<ManagementState> {
  ManagementCubit(
    this._getAssignablePointsUseCase,
    this._getQuestsUseCase,
    this._getMaxRoomDelayUseCase,
  ) : super(const ManagementLoading());

  final GetAssignablePointsUseCase _getAssignablePointsUseCase;
  final GetSignedUserQuestsUseCase _getQuestsUseCase;
  final GetMaxRoomDelayUseCase _getMaxRoomDelayUseCase;

  StreamSubscription<dynamic>? _subscription;

  void load() {
    _subscription =
        Rx.combineLatest3(
          _getAssignablePointsUseCase(),
          _getQuestsUseCase(),
          _getMaxRoomDelayUseCase(),
          (pointsResource, questsResource, delay) => (pointsResource, questsResource, delay),
        ).when(
      progress: () => emit(const ManagementLoading()),
      error: (_) => emit(const ManagementFailure()),
          success: (data) {
            final (pointsResource, questsResource, delay) = data;
            emit(
              ManagementLoaded(
                points: pointsResource,
                quests: questsResource,
                maxRoomDelay: delay,
              ),
            );
      },
        );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
