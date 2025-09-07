import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../state/day_sessions_cubit.dart';

class RoomSelector extends StatefulWidget {
  const RoomSelector({super.key, required this.rooms});

  final Set<NamedEntity> rooms;

  @override
  State<RoomSelector> createState() => _RoomSelectorState();
}

class _RoomSelectorState extends State<RoomSelector> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.rooms.length, vsync: this);
    context.read<DaySessionsCubit>().onRoomChanges(widget.rooms.elementAt(tabController.index));
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        context.read<DaySessionsCubit>().onRoomChanges(widget.rooms.elementAt(tabController.index));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: tabController,
      tabAlignment: TabAlignment.start,
      tabs: widget.rooms.map((room) => Tab(text: room.name)).toList(),
    );
  }
}
