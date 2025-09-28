import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import '../../../models/models.dart';
import 'day_sessions_state.dart';

@injectable
class DaySessionsCubit extends SafeEmitterCubit<DaySessionsState> {
  DaySessionsCubit(@factoryParam List<RoomSessions> sessions) : super(DaySessionsState(daySessions: sessions));

  void onRoomChanges(NamedEntity room) {
    emit(
      state.copyWith(
        selectedRoomSessions: state.daySessions.firstWhereOrNull((ds) => ds.room.id == room.id),
      ),
    );
  }
}
