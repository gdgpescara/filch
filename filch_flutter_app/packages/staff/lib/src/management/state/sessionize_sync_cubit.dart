import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:schedule/schedule.dart';

part 'sessionize_sync_state.dart';

@injectable
class SessionizeSyncCubit extends SafeEmitterCubit<SessionizeSyncState> {
  SessionizeSyncCubit(this._syncSessionizeUseCase) : super(SessionizeSyncInitial());

  final SyncSessionizeUseCase _syncSessionizeUseCase;

  void syncSessionizeData() {
    _syncSessionizeUseCase().when(
      progress: () => emit(SessionizeSyncInProgress()),
      success: (result) {
        if (result) {
          emit(SessionizeSyncSuccess());
        } else {
          emit(const SessionizeSyncFailure('No data was synced.'));
        }
      },
      error: (error) => emit(SessionizeSyncFailure(error.message)),
    );
  }
}
