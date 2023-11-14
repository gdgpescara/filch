import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_functionalities/widgets/dark_map_container.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import '../profile/user_profile_view.dart';
import '../quests/current_quest/current_quest_view.dart';
import '../ranking/houses_ranking_view.dart';
import 'state/user_home_cubit.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  static const routeName = 'user-homepage';

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int currentView = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserHomeCubit>(
      create: (context) => injector()..checkRankingFreezed(),
      child: BlocBuilder<UserHomeCubit, UserHomeState>(
        builder: (context, state) {
          currentView = state.isRankingFreezed ? 0 : currentView;
          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: DarkMapContainer(
              child: IndexedStack(
                index: currentView,
                children: [
                  const HousesRankingView(),
                  if (!state.isRankingFreezed) const CurrentQuestView(),
                  const UserProfileView(),
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
                  icon: const Icon(Icons.military_tech_outlined),
                  activeIcon: const Icon(Icons.military_tech_rounded),
                  tooltip: t.home.bottom_nav.ranking,
                  label: t.home.bottom_nav.ranking,
                ),
                if (!state.isRankingFreezed) BottomNavigationBarItem(
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
        },
      ),
    );
  }
}
