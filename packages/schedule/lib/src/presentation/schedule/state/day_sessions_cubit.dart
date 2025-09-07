import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import '../../../models/models.dart';
import 'day_sessions_state.dart';

@injectable
class DaySessionsCubit extends SafeEmitterCubit<DaySessionsState> {
  DaySessionsCubit(@factoryParam Map<String, List<Session>> sessions)
    : super(DaySessionsState(sessions: sessions, filteredSessions: const []));

  void onRoomChanges(NamedEntity room) {
    emit(state.copyWith(filteredSessions: state.sessions[room.name] ?? []));
  }
}
