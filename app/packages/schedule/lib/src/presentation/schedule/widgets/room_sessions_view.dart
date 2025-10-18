import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import '../state/day_sessions_cubit.dart';
import '../state/day_sessions_state.dart';
import 'current_and_future_sessions.dart';
import 'ended_sessions.dart';
import 'room_delay_header.dart';

class RoomSessionsView extends StatefulWidget {
  const RoomSessionsView({
    super.key,
    required this.onSessionTap,
    required this.onlyFavorites,
  });

  final bool onlyFavorites;
  final ValueChanged<String> onSessionTap;

  @override
  State<RoomSessionsView> createState() => _RoomSessionsViewState();
}

class _RoomSessionsViewState extends State<RoomSessionsView> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _scheduleNextRefresh();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _scheduleNextRefresh() {
    _refreshTimer?.cancel();

    final currentlyRunningSession = _getCurrentlyRunningSession();
    if (currentlyRunningSession == null) {
      return;
    }

    final now = DateTime.now();
    final timeUntilEnd = currentlyRunningSession.endsAt.difference(now);

    if (timeUntilEnd.isNegative) {
      _refreshAndScheduleNext();
      return;
    }

    _refreshTimer = Timer(timeUntilEnd, _refreshAndScheduleNext);
  }

  Session? _getCurrentlyRunningSession() {
    final state = context.read<DaySessionsCubit>().state;
    final roomSessions = state.selectedRoomSessions;

    if (roomSessions == null) return null;

    final sessionsToCheck = widget.onlyFavorites ? roomSessions.favoriteSessions : roomSessions.sessions;

    return sessionsToCheck.firstWhereOrNull(
      (session) => session.isCurrentlyRunning,
    );
  }

  void _refreshAndScheduleNext() {
    if (mounted) {
      setState(() {});
      _scheduleNextRefresh();
    }
  }

  List<Session> _getSessionsToDisplay(RoomSessions roomSessions) {
    if (widget.onlyFavorites) {
      return roomSessions.favoriteSessions;
    }
    return roomSessions.sessions;
  }

  (List<Session>, List<Session>) _partitionSessionsByStatus(List<Session> sessions) {
    final endedSessions = <Session>[];
    final currentAndFutureSessions = <Session>[];

    for (final session in sessions) {
      if (session.isEnded) {
        endedSessions.add(session);
        continue;
      }
      currentAndFutureSessions.add(session);
    }

    return (endedSessions, currentAndFutureSessions);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DaySessionsCubit, DaySessionsState, RoomSessions?>(
      selector: (state) => state.selectedRoomSessions,
      builder: (context, selectedRoomSessions) {
        if (selectedRoomSessions == null) {
          return Center(
            child: Text(t.schedule.sessions.no_sessions_for_room),
          );
        }

        final sessionsToDisplay = _getSessionsToDisplay(selectedRoomSessions);
        final (endedSessions, currentAndFutureSessions) = _partitionSessionsByStatus(sessionsToDisplay);

        return ListView(
          padding: const EdgeInsets.all(Spacing.m),
          children: [
            if (selectedRoomSessions.scheduleDelay > 0) ...[
              const SizedBox(height: Spacing.m),
              RoomDelayHeader(roomDelay: selectedRoomSessions.scheduleDelay),
              const SizedBox(height: Spacing.m),
            ],
            if(endedSessions.isNotEmpty) ...[
              EndedSessions(
                sessions: endedSessions,
                onSessionTap: widget.onSessionTap,
              ),
              const SizedBox(height: Spacing.m),
            ],
            CurrentAndFutureSessions(
              sessions: currentAndFutureSessions,
              onSessionTap: widget.onSessionTap,
            ),
          ],
        );
      },
    );
  }
}
