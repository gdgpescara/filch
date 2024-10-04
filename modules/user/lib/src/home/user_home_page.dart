import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
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
      create: (context) => GetIt.I(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return Scaffold(
            body: Background(
              child: IndexedStack(
                index: state.currentView,
                children: [
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
            bottomNavigationBar: BottomNavigationBar(
              enableFeedback: true,
              currentIndex: state.currentView,
              onTap: context.read<HomePageCubit>().changeView,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.military_tech_outlined),
                  activeIcon: const Icon(Icons.military_tech_rounded),
                  tooltip: t.common.home.bottom_nav.ranking,
                  label: t.common.home.bottom_nav.ranking,
                ),
                if (!state.isRankingFreezed)
                  BottomNavigationBarItem(
                    icon: const Icon(FontAwesomeIcons.handLizard),
                    activeIcon: const Icon(FontAwesomeIcons.solidHandLizard),
                    tooltip: t.common.home.bottom_nav.current_quest,
                    label: t.common.home.bottom_nav.current_quest,
                  ),
                BottomNavigationBarItem(
                  icon: const Icon(FontAwesomeIcons.user),
                  activeIcon: const Icon(FontAwesomeIcons.solidUser),
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
