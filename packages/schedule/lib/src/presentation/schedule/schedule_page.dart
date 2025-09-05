import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ui/ui.dart';

import 'cubit/schedule_cubit.dart';
import 'cubit/schedule_state.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key, required this.embedded});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>(
      create: (context) => GetIt.I()..init(),
      child: BlocBuilder<ScheduleCubit, ScheduleState>(
        buildWhen: (previous, current) =>
            current is! ScheduleLoaded && previous != current ||
            current is ScheduleLoaded && previous is ScheduleLoaded && current.groupedSessions != previous.groupedSessions,
        builder: (context, state) {
          final body = Scaffold(
            backgroundColor: _bgColor,
            appBar: AppBar(
              backgroundColor: _bgColor,
              shadowColor: _bgColor,
              forceMaterialTransparency: embedded,
              elevation: _elevation,
              bottom: state is ScheduleLoaded
                  ? TabBar(
                      isScrollable: true,
                      tabs: state.groupedSessions.availableDays.map((day) => Tab(text: DateFormat.MMMd().format(day))).toList(),
                    )
                  : null,
            ),
            body: Padding(
              padding: _padding,
              child: state is ScheduleLoaded
                  ? TabBarView(
                      children: [
                        Text(state.groupedSessions.sessionsByDay.toString()),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          );

          if (embedded) {
            return body;
          }
          return Background(child: body);
        },
      ),
    );
  }

  Color? get _bgColor => embedded ? Colors.transparent : null;

  double? get _elevation => embedded ? 0 : null;

  EdgeInsets get _padding {
    return const EdgeInsets.all(Spacing.m);
  }
}
