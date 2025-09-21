import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:intl/intl.dart';
import 'package:ui/ui.dart';

import 'state/schedule_cubit.dart';
import 'state/schedule_state.dart';
import 'widgets/day_sessions.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({
    super.key,
    required this.navigateToSessionDetail,
    required this.embedded,
  });

  final ValueChanged<String> navigateToSessionDetail;
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>(
      create: (context) => GetIt.I()..init(),
      child: BlocBuilder<ScheduleCubit, ScheduleState>(
        buildWhen: _shouldRebuild,
        builder: (context, state) {
          final body = _buildScheduleScaffold(context, state);
          return embedded ? body : Background(child: body);
        },
      ),
    );
  }

  bool _shouldRebuild(ScheduleState previous, ScheduleState current) {
    return previous != current ||
        (current is ScheduleLoaded &&
            previous is ScheduleLoaded &&
            (current.groupedSessions != previous.groupedSessions || current.onlyFavorites != previous.onlyFavorites));
  }

  Widget _buildScheduleScaffold(BuildContext context, ScheduleState state) {
    return DefaultTabController(
      length: _getTabLength(state),
      child: Scaffold(
        backgroundColor: _bgColor,
        appBar: _buildAppBar(context, state),
        body: _buildBody(state),
      ),
    );
  }

  int _getTabLength(ScheduleState state) {
    return state is ScheduleLoaded ? state.groupedSessions.getAvailableDays(onlyFavorites: state.onlyFavorites).length : 0;
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ScheduleState state) {
    return AppBar(
      backgroundColor: _bgColor,
      shadowColor: _bgColor,
      forceMaterialTransparency: embedded,
      elevation: _elevation,
      actions: [
        TextButton(
          onPressed: context.read<ScheduleCubit>().toggleOnlyFavorites,
          child: Text(
            state is ScheduleLoaded && state.onlyFavorites
                ? context.t.schedule.sessions.show_all
                : context.t.schedule.sessions.show_favorites,
            style: context.getTextTheme(TextThemeType.monospace).bodyMedium?.copyWith(color: context.colorScheme.primary),
          ),
        ),
      ],
      bottom: _buildTabBar(state),
    );
  }

  TabBar? _buildTabBar(ScheduleState state) {
    if (state is! ScheduleLoaded) return null;

    return TabBar(
      tabs: state.groupedSessions
          .getAvailableDays(onlyFavorites: state.onlyFavorites)
          .map((day) => Tab(text: DateFormat.MMMd().format(day)))
          .toList(),
    );
  }

  Widget _buildBody(ScheduleState state) {
    return switch (state) {
      ScheduleLoaded(groupedSessions: final groupedSessions) => TabBarView(
        children: groupedSessions.getAvailableDays(onlyFavorites: state.onlyFavorites).map((day) => _buildDaySession(state, day)).toList(),
      ),
      ScheduleLoading() => const Center(child: CircularProgressIndicator()),
      ScheduleError(message: final message) => Center(child: Text(message)),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildDaySession(ScheduleLoaded state, DateTime day) {
    final sessions = state.groupedSessions.getSessionsForDay(day, onlyFavorites: state.onlyFavorites);
    if (sessions == null) return const SizedBox.shrink();

    return DaySessions(
      sessions: sessions,
      onSessionTap: navigateToSessionDetail,
      rooms: state.groupedSessions.getRoomsForDay(day, onlyFavorites: state.onlyFavorites),
    );
  }

  Color? get _bgColor => embedded ? Colors.transparent : null;

  double? get _elevation => embedded ? 0 : null;
}
