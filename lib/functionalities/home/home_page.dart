import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';
import '../_shared/widgets/dark_map_container.dart';
import '../quests/archived_quests/archived_quests_view.dart';
import '../quests/current_quest/current_quest_view.dart';
import '../user/profile/profile_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = 'homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentView = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: DarkMapContainer(
        child: IndexedStack(
          index: currentView,
          children: const [
            ArchivedQuestsView(),
            CurrentQuestView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        enableFeedback: true,
        currentIndex: currentView,
        onTap: (index) => setState(() => currentView = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.videogame_asset_outlined),
            activeIcon: const Icon(Icons.videogame_asset_rounded),
            tooltip: t.home.bottom_nav.archived_quests,
            label: t.home.bottom_nav.archived_quests,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.location_searching_rounded),
            activeIcon: const Icon(Icons.my_location),
            tooltip: t.home.bottom_nav.current_quest,
            label: t.home.bottom_nav.current_quest,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_rounded),
            activeIcon: const Icon(Icons.person_rounded),
            tooltip: t.home.bottom_nav.profile,
            label: t.home.bottom_nav.profile,
          ),
        ],
      ),
    );
  }
}
