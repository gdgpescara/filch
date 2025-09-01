import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../models/session.dart';
import 'cubit/schedule_cubit.dart';
import 'cubit/schedule_state.dart';
import 'widgets/session_card.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _dayTabs = ['Day 1', 'Day 2', 'Day 3'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _dayTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ScheduleCubit>()..loadSchedule(),
      child: Scaffold(
        backgroundColor: const Color(0xFF19192D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF19192D),
          foregroundColor: Colors.white,
          title: const Text(
            'Event Schedule',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFF4285F4),
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
            tabs: _dayTabs.map((day) => Tab(text: day)).toList(),
          ),
        ),
        body: BlocBuilder<ScheduleCubit, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleInitial) {
              return const Center(
                child: Text(
                  'Tap to load schedule',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (state is ScheduleLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
                ),
              );
            } else if (state is ScheduleLoaded) {
              return TabBarView(
                controller: _tabController,
                children: _buildScheduleForDays(state),
              );
            } else if (state is ScheduleError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading schedule',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.read<ScheduleCubit>().loadSchedule(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Unknown state',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _buildScheduleForDays(ScheduleLoaded state) {
    final sortedDays = state.sessionsByDay.keys.toList()..sort();
    
    // If we have fewer days than tabs, fill with empty widgets
    final widgets = <Widget>[];
    for (int i = 0; i < _dayTabs.length; i++) {
      if (i < sortedDays.length) {
        widgets.add(_buildDaySchedule(sortedDays[i], state));
      } else {
        widgets.add(_buildEmptyDay());
      }
    }
    return widgets;
  }

  Widget _buildDaySchedule(DateTime day, ScheduleLoaded state) {
    final sessionsByTime = state.sessionsByDay[day];
    if (sessionsByTime == null || sessionsByTime.isEmpty) {
      return _buildEmptyDay();
    }

    final sortedTimes = sessionsByTime.keys.toList()..sort();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedTimes.length,
      itemBuilder: (context, index) {
        final timeSlot = sortedTimes[index];
        final sessions = sessionsByTime[timeSlot] ?? [];
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                DateFormat('h:mm a').format(timeSlot),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            
            // Sessions for this time slot
            ...sessions.map((session) => SessionCard(
              session: session,
              isFavorite: state.bookmarkedSessions.contains(session.id),
              onTap: () => _openSessionDetail(session),
              onFavoriteToggle: () => context
                  .read<ScheduleCubit>()
                  .toggleFavorite(session.id),
            )),
            
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildEmptyDay() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'No sessions scheduled',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  void _openSessionDetail(Session session) {
    // TODO: Navigate to session detail page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening session: ${session.title}'),
        backgroundColor: const Color(0xFF4285F4),
      ),
    );
  }
}
