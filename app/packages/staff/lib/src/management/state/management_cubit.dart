import 'dart:async';

import 'package:auth/auth.dart';
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
    this._countUsersWithTShirtUseCase,
    this._countUsersWithoutTShirtUseCase,
    this._isSponsorUserUseCase,
  ) : super(const ManagementLoading());

  final GetAssignablePointsUseCase _getAssignablePointsUseCase;
  final GetSignedUserQuestsUseCase _getQuestsUseCase;
  final GetMaxRoomDelayUseCase _getMaxRoomDelayUseCase;
  final CountUsersWithTShirtUseCase _countUsersWithTShirtUseCase;
  final CountUsersWithoutTShirtUseCase _countUsersWithoutTShirtUseCase;
  final IsSponsorUserUseCase _isSponsorUserUseCase;

  StreamSubscription<dynamic>? _subscription;

  void load() {
    _subscription =
        Rx.combineLatest6(
          _isSponsorUserUseCase().asStream(),
          _getAssignablePointsUseCase(),
          _getQuestsUseCase(),
          _getMaxRoomDelayUseCase(),
          _countUsersWithTShirtUseCase(),
          _countUsersWithoutTShirtUseCase(),
          (isSponsor, points, quests, delay, countWithTShirt, countWithoutTShirt) =>
              (isSponsor, points, quests, delay, countWithTShirt, countWithoutTShirt),
        ).when(
          progress: () => emit(const ManagementLoading()),
          error: (_) => emit(const ManagementFailure()),
          success: (data) {
            final (isSponsor, pointsResource, questsResource, delay, countWithTShirt, countWithoutTShirt) = data;
            emit(
              ManagementLoaded(
                isSponsor: isSponsor,
                points: pointsResource,
                quests: questsResource,
                maxRoomDelay: delay,
                countUsersWithTShirt: countWithTShirt,
                countUsersWithoutTShirt: countWithoutTShirt,
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
