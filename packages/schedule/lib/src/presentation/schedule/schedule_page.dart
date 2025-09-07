import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ui/ui.dart';

import 'state/schedule_cubit.dart';
import 'state/schedule_state.dart';
import 'widgets/day_sessions.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key, required this.embedded});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>(
      create: (context) => GetIt.I()..init(),
      child: BlocBuilder<ScheduleCubit, ScheduleState>(
        buildWhen: _shouldRebuild,
        builder: (context, state) {
          final body = _buildScheduleScaffold(state);
          return embedded ? body : Background(child: body);
        },
      ),
    );
  }

  bool _shouldRebuild(ScheduleState previous, ScheduleState current) {
    return previous != current ||
        (current is ScheduleLoaded &&
            previous is ScheduleLoaded &&
            current.groupedSessions != previous.groupedSessions);
  }

  Widget _buildScheduleScaffold(ScheduleState state) {
    return DefaultTabController(
      length: _getTabLength(state),
      child: Scaffold(
        backgroundColor: _bgColor,
        appBar: _buildAppBar(state),
        body: _buildBody(state),
      ),
    );
  }

  int _getTabLength(ScheduleState state) {
    return state is ScheduleLoaded ? state.groupedSessions.availableDays.length : 0;
  }

  PreferredSizeWidget _buildAppBar(ScheduleState state) {
    return AppBar(
      backgroundColor: _bgColor,
      shadowColor: _bgColor,
      forceMaterialTransparency: embedded,
      elevation: _elevation,
      bottom: _buildTabBar(state),
    );
  }

  TabBar? _buildTabBar(ScheduleState state) {
    if (state is! ScheduleLoaded) return null;

    return TabBar(
      tabs: state.groupedSessions.availableDays.map((day) => Tab(text: DateFormat.MMMd().format(day))).toList(),
    );
  }

  Widget _buildBody(ScheduleState state) {
    if (state is! ScheduleLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    return TabBarView(
      children: state.groupedSessions.availableDays.map((day) => _buildDaySession(state, day)).toList(),
    );
  }

  Widget _buildDaySession(ScheduleLoaded state, DateTime day) {
    final sessions = state.groupedSessions.getSessionsForDay(day);
    if (sessions == null) return const SizedBox.shrink();

    return DaySessions(
      sessions: sessions,
      rooms: state.groupedSessions.getRoomsForDay(day),
    );
  }

  Color? get _bgColor => embedded ? Colors.transparent : null;

  double? get _elevation => embedded ? 0 : null;
}
