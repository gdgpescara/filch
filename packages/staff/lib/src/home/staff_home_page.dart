import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i18n/i18n.dart';
import 'package:schedule/schedule.dart';
import 'package:ui/ui.dart';

import '../../staff.dart';
import '../profile/staff_profile_view.dart';
import '../scan/scan_view.dart';
import '../shifts/shifts_view.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({
    super.key,
    required this.navigateToSplash,
    required this.navigateToAssignment,
    required this.navigateToTShirtAssignment,
  });

  final VoidCallback navigateToSplash;
  final VoidCallback navigateToTShirtAssignment;
  final void Function(AssignmentPageArgs) navigateToAssignment;

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Background(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            const SchedulePage(embedded: true),
            ScanView(
              navigateToAssignment: widget.navigateToAssignment,
              navigateToTShirtAssignment: widget.navigateToTShirtAssignment,
            ),
            const ShiftsView(),
            StaffProfileView(navigateToSplash: widget.navigateToSplash),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          NavigationDestination(
            icon: const Icon(FontAwesomeIcons.calendar),
            selectedIcon: const Icon(FontAwesomeIcons.solidCalendar),
            tooltip: t.common.home.bottom_nav.sessions,
            label: t.common.home.bottom_nav.sessions,
          ),
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
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            tooltip: t.staff.home.bottom_nav.profile,
            label: t.staff.home.bottom_nav.profile,
          ),
        ],
      ),
    );
  }
}
