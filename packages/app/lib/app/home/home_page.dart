import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
import 'package:routefly/routefly.dart';
import 'package:schedule/schedule.dart';
import 'package:staff/staff.dart';
import 'package:ui/ui.dart';
import 'package:user/user.dart';

import '../../application.dart';
import 'state/home_page_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToSplash() {
    Routefly.navigate(routePaths.path);
  }

  void _navigateToLogin() {
    Routefly.navigate(routePaths.signIn);
  }

  void _navigateToAllPoints() {
    Routefly.pushNavigate(routePaths.user.allPoints);
  }

  void _navigateToSessionDetail(String sessionId) {
    Routefly.pushNavigate(routePaths.session.$id.replaceAll('[id]', sessionId));
  }

  void _navigateToAssignment(AssignmentPageArgs args) {
    Routefly.pushNavigate(
      routePaths.staff.pointAssignment,
      arguments: args.copyWith(onAssignDone: Routefly.pop<void>),
    );
  }

  void _navigateToTShirtAssignment() {
    Routefly.pushNavigate(routePaths.staff.tShirtAssignment);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
      create: (context) => GetIt.I()..init(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return Scaffold(
            body: Background(
              child: IndexedStack(
                index: state.currentView,
                children: [
                  SchedulePage(
                    navigateToSessionDetail: _navigateToSessionDetail,
                    embedded: true,
                  ),
                  const RankingPage(),
                  if (!state.isRankingFreezed && !state.isStaffUser) const CurrentQuestPage(),
                  if (state.isStaffUser) ...[
                    ManagementView(
                      navigateToAssignment: _navigateToAssignment,
                      navigateToTShirtAssignment: _navigateToTShirtAssignment,
                    ),
                    const ShiftsView(),
                  ],
                  UserProfilePage(
                    navigateToSplash: _navigateToSplash,
                    navigateToLogin: _navigateToLogin,
                    navigateToAllPoints: _navigateToAllPoints,
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
                if (!state.isRankingFreezed && !state.isStaffUser)
                  NavigationDestination(
                    icon: const Icon(FontAwesomeIcons.handLizard),
                    selectedIcon: const Icon(FontAwesomeIcons.solidHandLizard),
                    tooltip: t.common.home.bottom_nav.current_quest,
                    label: t.common.home.bottom_nav.current_quest,
                  ),
                if (state.isStaffUser) ...[
                  NavigationDestination(
                    icon: const Icon(Icons.qr_code_scanner_outlined),
                    selectedIcon: const Icon(Icons.qr_code_scanner_rounded),
                    tooltip: t.staff.home.bottom_nav.scan,
                    label: t.staff.home.bottom_nav.scan,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.access_time_rounded),
                    selectedIcon: const Icon(Icons.access_time_filled_rounded),
                    tooltip: t.staff.home.bottom_nav.shifts,
                    label: t.staff.home.bottom_nav.shifts,
                  ),
                ],
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
