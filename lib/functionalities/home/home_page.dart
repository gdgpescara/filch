import 'package:flutter/material.dart';

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
      body: IndexedStack(
        index: currentView,
        children: const [
          Center(child: Text('Quests')),
          Center(child: Text('current quest')),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        currentIndex: currentView,
        onTap: (index) => setState(() => currentView = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset_outlined),
            activeIcon: Icon(Icons.videogame_asset_rounded),
            tooltip: 'Archived quests',
            label: 'Archived quests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_searching_rounded),
            activeIcon: Icon(Icons.my_location),
            tooltip: 'Current quest',
            label: 'Current quest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            tooltip: 'Profile',
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
