import 'dart:async';

import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:media_manager/media_manager.dart';
import 'package:sorting_ceremony/sorting_ceremony.dart';

part 'bootstrap_state.dart';

@injectable
class BootstrapCubit extends Cubit<BootstrapState> {
  BootstrapCubit(
    this._hasSignedUserUseCase,
    this._staffUserUseCase,
    this._sponsorUserUseCase,
    this._needSortingCeremonyUseCase,
    this._uploadQueueExecutorUseCase,
    this._getFeatureFlagsUseCase,
  ) : super(const BootstrapProcessing());

  final HasSignedUserUseCase _hasSignedUserUseCase;
  final IsStaffUserUseCase _staffUserUseCase;
  final IsSponsorUserUseCase _sponsorUserUseCase;
  final UserNeedSortingCeremonyUseCase _needSortingCeremonyUseCase;
  final UploadQueueExecutorUseCase _uploadQueueExecutorUseCase;
  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;

  final List<StreamSubscription<void>?> _subscriptions = [];

  @override
  Future<void> close() {
    unawaited(Future.wait(_subscriptions.map((subscription) => subscription?.cancel()).nonNulls));
    return super.close();
  }

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!await _hasSignedUserUseCase()) {
      await Future.wait(_subscriptions.map((subscription) => subscription?.cancel()).nonNulls);
      emit(const UserLoggedOut());
      return;
    }

    final (isStaff, isSponsor) = await (
      _staffUserUseCase(),
      _sponsorUserUseCase(),
    ).wait;

    final staffUser = isStaff || isSponsor;

    _subscriptions.add(
      _getFeatureFlagsUseCase().when(
        progress: () => emit(const BootstrapProcessing()),
        success: (flags) async {
          if (flags['afterDevFest'] ?? false) {
            emit(const AfterDevFest());
            return;
          }
          if (await _needSortingCeremonyUseCase()) {
            emit(const UserNeedSortingCeremony());
            return;
          }
          if (staffUser) {
            _subscriptions.add(_uploadQueueExecutorUseCase());
          }
          emit(const AppCanRun());
        },
        error: (_) => emit(const AppCanRun()),
      ),
    );
  }
}
