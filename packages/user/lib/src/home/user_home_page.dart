import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
import 'package:schedule/schedule.dart';
import 'package:ui/ui.dart';

import '../profile/user_profile_page.dart';
import 'state/home_page_cubit.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({
    super.key,
    required this.navigateToSplash,
    required this.navigateToLogin,
    required this.navigateToAllPoints,
  });

  final VoidCallback navigateToSplash;
  final VoidCallback navigateToLogin;
  final VoidCallback navigateToAllPoints;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (context) => GetIt.I()..checkRankingFreezed(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return Scaffold(
            body: Background(
              child: IndexedStack(
                index: state.currentView,
                children: [
                  const SchedulePage(embedded: true),
                  const RankingPage(),
                  if (!state.isRankingFreezed) const CurrentQuestPage(),
                  UserProfilePage(
                    navigateToSplash: navigateToSplash,
                    navigateToLogin: navigateToLogin,
                    navigateToAllPoints: navigateToAllPoints,
                    embedded: true,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.transparent,
              selectedIndex: state.currentView,
              onDestinationSelected: context.read<HomePageCubit>().changeView,
              destinations: [
                NavigationDestination(
                  icon: const Icon(FontAwesomeIcons.calendar),
                  selectedIcon: const Icon(FontAwesomeIcons.solidCalendar),
                  tooltip: t.common.home.bottom_nav.sessions,
                  label: t.common.home.bottom_nav.sessions,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.military_tech_outlined),
                  selectedIcon: const Icon(Icons.military_tech_rounded),
                  tooltip: t.common.home.bottom_nav.ranking,
                  label: t.common.home.bottom_nav.ranking,
                ),
                if (!state.isRankingFreezed)
                  NavigationDestination(
                    icon: const Icon(FontAwesomeIcons.handLizard),
                    selectedIcon: const Icon(FontAwesomeIcons.solidHandLizard),
                    tooltip: t.common.home.bottom_nav.current_quest,
                    label: t.common.home.bottom_nav.current_quest,
                  ),
                NavigationDestination(
                  icon: const Icon(FontAwesomeIcons.user),
                  selectedIcon: const Icon(FontAwesomeIcons.solidUser),
                  tooltip: t.common.home.bottom_nav.profile,
                  label: t.common.home.bottom_nav.profile,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
