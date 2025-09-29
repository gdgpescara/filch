import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import '../state/day_sessions_cubit.dart';
import 'room_selector.dart';
import 'room_sessions_view.dart';

class DaySessionsView extends StatelessWidget {
  const DaySessionsView({
    super.key,
    required this.daySessions,
    required this.rooms,
    required this.onlyFavorites,
    required this.onSessionTap,
  });

  final List<RoomSessions> daySessions;
  final Set<NamedEntity> rooms;
  final bool onlyFavorites;
  final ValueChanged<String> onSessionTap;

  @override
  Widget build(BuildContext context) {
    if (daySessions.isEmpty) {
      return Center(
        child: Text(
          t.schedule.sessions.no_sessions_for_day,
          style: context.textTheme.bodyMedium,
        ),
      );
    }

    return BlocProvider<DaySessionsCubit>(
      key: ValueKey(daySessions.map((rs) => '${rs.room.id}-${rs.scheduleDelay}').join(',')),
      create: (context) => GetIt.I(param1: daySessions),
      child: DefaultTabController(
        length: rooms.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoomSelector(rooms: rooms),
            Expanded(
              child: RoomSessionsView(onlyFavorites: onlyFavorites, onSessionTap: onSessionTap),
            ),
          ],
        ),
      ),
    );
  }
}
