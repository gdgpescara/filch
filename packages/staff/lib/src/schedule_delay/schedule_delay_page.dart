import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'room_list.dart';
import 'state/schedule_delay_cubit.dart';

class ScheduleDelayPage extends StatelessWidget {
  const ScheduleDelayPage({super.key, required this.onDone});

  final ValueChanged<BuildContext> onDone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleDelayCubit>(
      create: (context) => GetIt.I()..init(),
      child: Background(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text(t.staff.schedule_delay.available_rooms_title)),
          body: BlocBuilder<ScheduleDelayCubit, ScheduleDelayState>(
            builder: (context, state) {
              return switch (state) {
                ScheduleDelayLoading() => const Center(child: CircularProgressIndicator()),
                ScheduleDelayLoaded(rooms: final rooms) => RoomList(rooms: rooms),
                ScheduleDelayFailure() => ErrorView(onRetry: () => context.read<ScheduleDelayCubit>().init()),
              };
            },
          ),
        ),
      ),
    );
  }
}
