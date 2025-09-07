import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import '../state/day_sessions_cubit.dart';
import '../state/day_sessions_state.dart';
import 'session_card/session_card.dart';

class RoomSessions extends StatelessWidget {
  const RoomSessions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DaySessionsCubit, DaySessionsState, List<Session>>(
      selector: (state) => state.filteredSessions,
      builder: (context, filteredSessions) {
        if (filteredSessions.isEmpty) {
          return const Center(child: Text('Nessun talk disponibile per la sala selezionata.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(Spacing.m),
          itemCount: filteredSessions.length,
          itemBuilder: (context, index) => SessionCard(filteredSessions[index]),
          separatorBuilder: (context, index) => const SizedBox(height: Spacing.m),
        );
      },
    );
  }
}
