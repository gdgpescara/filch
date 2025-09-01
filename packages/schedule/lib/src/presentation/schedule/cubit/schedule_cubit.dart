import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../models/grouped_sessions.dart';
import '../../../use_cases/bookmark_use_cases.dart';
import '../../../use_cases/get_grouped_sessions_use_case.dart';
import 'schedule_state.dart';

@injectable
class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(
    this._getGroupedSessionsUseCase,
    this._toggleSessionBookmarkUseCase,
    this._isSessionBookmarkedUseCase,
  ) : super(const ScheduleInitial());

  final GetGroupedSessionsUseCase _getGroupedSessionsUseCase;
  final ToggleSessionBookmarkUseCase _toggleSessionBookmarkUseCase;
  final IsSessionBookmarkedUseCase _isSessionBookmarkedUseCase;

  StreamSubscription<GroupedSessions>? _sessionsSubscription;
  final Set<String> _bookmarkedSessions = <String>{};

  /// Load the schedule data
  Future<void> loadSchedule() async {
    try {
      emit(const ScheduleLoading());

      // Start listening to sessions
      _sessionsSubscription?.cancel();
      _sessionsSubscription = _getGroupedSessionsUseCase().listen(
        (groupedSessions) async {
          // Load bookmark status for all sessions
          final allSessions = groupedSessions.sessionsByDay.values
              .expand((sessionsByTime) => sessionsByTime.values)
              .expand((sessions) => sessions);

          _bookmarkedSessions.clear();
          for (final session in allSessions) {
            final isBookmarked = await _isSessionBookmarkedUseCase(session.id);
            if (isBookmarked) {
              _bookmarkedSessions.add(session.id);
            }
          }

          emit(ScheduleLoaded(
            sessionsByDay: groupedSessions.sessionsByDay,
            bookmarkedSessions: Set.from(_bookmarkedSessions),
          ));
        },
        onError: (Object error) {
          emit(ScheduleError(message: error.toString()));
        },
      );
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  /// Toggle bookmark status for a session
  Future<void> toggleFavorite(String sessionId) async {
    final currentState = state;
    if (currentState is! ScheduleLoaded) return;

    try {
      // Optimistically update the UI
      final updatedBookmarks = Set<String>.from(currentState.bookmarkedSessions);
      if (updatedBookmarks.contains(sessionId)) {
        updatedBookmarks.remove(sessionId);
        _bookmarkedSessions.remove(sessionId);
      } else {
        updatedBookmarks.add(sessionId);
        _bookmarkedSessions.add(sessionId);
      }

      emit(currentState.copyWith(bookmarkedSessions: updatedBookmarks));

      // Perform the actual bookmark operation
      await _toggleSessionBookmarkUseCase(ToggleBookmarkParams(sessionId: sessionId));
    } catch (e) {
      // Revert the optimistic update on error
      emit(currentState);
    }
  }

  /// Check if a session is bookmarked
  bool isBookmarked(String sessionId) {
    return _bookmarkedSessions.contains(sessionId);
  }

  @override
  Future<void> close() {
    _sessionsSubscription?.cancel();
    return super.close();
  }
}
