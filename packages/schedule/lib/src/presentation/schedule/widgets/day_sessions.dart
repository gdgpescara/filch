import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import '../state/day_sessions_cubit.dart';
import 'room_selector.dart';
import 'room_sessions.dart';

class DaySessions extends StatelessWidget {
  const DaySessions({
    super.key,
    required this.sessions,
    required this.rooms,
  });

  final Map<String, List<Session>> sessions;
  final Set<NamedEntity> rooms;

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return Center(
        child: Text(
          'Nessuna sessione disponibile per questo giorno',
          style: context.textTheme.bodyMedium,
        ),
      );
    }

    return BlocProvider<DaySessionsCubit>(
      create: (context) => GetIt.I(param1: sessions),
      child: DefaultTabController(
        length: rooms.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoomSelector(rooms: rooms),
            const Expanded(child: RoomSessions()),
          ],
        ),
      ),
    );
  }
}
