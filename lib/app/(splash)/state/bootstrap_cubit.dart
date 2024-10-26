import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sorting_ceremony/sorting_ceremony.dart';

part 'bootstrap_state.dart';

@injectable
class BootstrapCubit extends Cubit<BootstrapState> {
  BootstrapCubit(
    this._hasSignedUserUseCase,
    this._isStaffUserUseCase,
    this._needSortingCeremonyUseCase,
  ) : super(const BootstrapProcessing());

  final HasSignedUserUseCase _hasSignedUserUseCase;
  final IsStaffUserUseCase _isStaffUserUseCase;
  final UserNeedSortingCeremonyUseCase _needSortingCeremonyUseCase;

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!_hasSignedUserUseCase()) {
      emit(const UserLoggedOut());
      return;
    }
    if (await _needSortingCeremonyUseCase()) {
      emit(const UserNeedSortingCeremony());
      return;
    }
    if (_isStaffUserUseCase()) {
      emit(const StaffUserLoggedIn());
      return;
    }
    emit(const AppCanRun());
  }
}
