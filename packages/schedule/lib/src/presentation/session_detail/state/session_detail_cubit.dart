import 'dart:async';

import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../../use_cases/get_session_by_id_use_case.dart';
import 'session_detail_state.dart';

@injectable
class SessionDetailCubit extends SafeEmitterCubit<SessionDetailState> {
  SessionDetailCubit(this._getSessionByIdUseCase) : super(SessionDetailInitial());

  StreamSubscription<dynamic>? _sessionSubscription;

  final GetSessionByIdUseCase _getSessionByIdUseCase;

  void init(String sessionId) {
    if (sessionId.isEmpty) {
      emit(SessionDetailError(error: 'Session ID is required'));
      return;
    }

    _sessionSubscription = _getSessionByIdUseCase(sessionId).when(
      progress: () => emit(SessionDetailLoading()),
      success: (data) => emit(SessionDetailLoaded(session: data.$1, delay: data.$2)),
      error: (error) => emit(SessionDetailError(error: error.toString())),
    );
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}
