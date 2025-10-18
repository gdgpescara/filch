import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:schedule/schedule.dart';
import 'package:ui/ui.dart';

import 'room_card.dart';
import 'state/room_card_cubit.dart';

class RoomList extends StatelessWidget {
  const RoomList({super.key, required this.rooms});

  final List<NamedEntity> rooms;

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return Center(child: Text(t.staff.schedule_delay.no_rooms_available, style: context.textTheme.bodySmall));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(Spacing.m),
      itemCount: rooms.length,
      separatorBuilder: (context, index) => const Gap.vertical(Spacing.m),
      itemBuilder: (context, index) {
        final room = rooms[index];
        return BlocProvider<RoomCardCubit>(
          create: (context) => RoomCardCubit(
            room,
            GetIt.I<GetRoomDelayUseCase>(),
            GetIt.I<RegisterRoomDelayUseCase>(),
          ),
          child: RoomCard(room: room),
        );
      },
    );
  }
}
