import 'dart:async';

import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
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
  ) : super(const BootstrapProcessing());

  final HasSignedUserUseCase _hasSignedUserUseCase;
  final IsStaffUserUseCase _isStaffUserUseCase;
  final UserNeedSortingCeremonyUseCase _needSortingCeremonyUseCase;
  final UploadQueueExecutorUseCase _uploadQueueExecutorUseCase;

  StreamSubscription<void>? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!_hasSignedUserUseCase()) {
      await _subscription?.cancel();
      emit(const UserLoggedOut());
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
  }
}
