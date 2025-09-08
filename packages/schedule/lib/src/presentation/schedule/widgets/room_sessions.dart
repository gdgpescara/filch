import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';

import '../../../models/models.dart';
import '../state/day_sessions_cubit.dart';
import '../state/day_sessions_state.dart';
import 'current_and_future_sessions.dart';
import 'ended_sessions.dart';

class RoomSessions extends StatefulWidget {
  const RoomSessions({super.key, required this.onSessionTap});

  final ValueChanged<String> onSessionTap;

  @override
  State<RoomSessions> createState() => _RoomSessionsState();
}

class _RoomSessionsState extends State<RoomSessions> {
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

    final state = context.read<DaySessionsCubit>().state;
    final runningSessions = state.filteredSessions.firstWhereOrNull((session) => session.isCurrentlyRunning);

    if (runningSessions != null) {
      final now = DateTime.now();
      final timeUntilEnd = runningSessions.endsAt.difference(now);

      if (timeUntilEnd.isNegative) {
        _refreshAndScheduleNext();
        return;
      }

      _refreshTimer = Timer(timeUntilEnd, _refreshAndScheduleNext);
    }
  }

  void _refreshAndScheduleNext() {
    if (mounted) {
      setState(() {});
      _scheduleNextRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DaySessionsCubit, DaySessionsState, List<Session>>(
      selector: (state) => state.filteredSessions,
      builder: (context, filteredSessions) {
        if (filteredSessions.isEmpty) {
          return Center(
            child: Text(t.schedule.sessions.no_sessions_for_room),
          );
        }

        // Separa le sessioni per stato temporale
        final endedSessions = filteredSessions.where((session) => session.hasEnded).toList();
        final currentAndFutureSessions = filteredSessions.where((session) => !session.hasEnded).toList();

        return ListView(
          children: [
            EndedSessions(
              sessions: endedSessions,
              onSessionTap: widget.onSessionTap,
            ),
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
