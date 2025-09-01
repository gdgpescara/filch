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
    this._isStaffUserUseCase,
    this._needSortingCeremonyUseCase,
    this._uploadQueueExecutorUseCase,
    this._getFeatureFlagsUseCase,
  ) : super(const BootstrapProcessing());

  final HasSignedUserUseCase _hasSignedUserUseCase;
  final IsStaffUserUseCase _isStaffUserUseCase;
  final UserNeedSortingCeremonyUseCase _needSortingCeremonyUseCase;
  final UploadQueueExecutorUseCase _uploadQueueExecutorUseCase;
  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;

  StreamSubscription<void>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!await _hasSignedUserUseCase()) {
      await _subscription?.cancel();
      emit(const UserLoggedOut());
      return;
    }

    _subscription = _getFeatureFlagsUseCase().when(
      progress: () => emit(const BootstrapProcessing()),
      success: (flags) async {
        if (flags['beforeDevFest'] ?? false) {
          emit(const BeforeDevFest());
          return;
        }
        if (flags['afterDevFest'] ?? false) {
          emit(const AfterDevFest());
          return;
        }
        if (await _needSortingCeremonyUseCase()) {
          emit(const UserNeedSortingCeremony());
          return;
        }
        if (_isStaffUserUseCase()) {
          _subscription = _uploadQueueExecutorUseCase();
          emit(const StaffUserLoggedIn());
          return;
        }
        emit(const AppCanRun());
      },
      error: (_) => emit(const AppCanRun()),
    );
  }
}
