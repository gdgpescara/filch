import 'package:flutter/material.dart';

import 'personal/personal_archived_quests_tab.dart';

class ArchivedQuestsView extends StatefulWidget {
  const ArchivedQuestsView({super.key});

  @override
  State<ArchivedQuestsView> createState() => _ArchivedQuestsViewState();
}

class _ArchivedQuestsViewState extends State<ArchivedQuestsView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PersonalArchivedQuestsTab(),
                Center(
                  child: Text('House'),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Personal'),
              Tab(text: 'House'),
            ],
          ),
        ],
      ),
    );
  }
}
