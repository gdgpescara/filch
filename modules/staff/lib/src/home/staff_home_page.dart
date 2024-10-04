import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
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
  });

  final VoidCallback navigateToSplash;
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
            ScanView(navigateToAssignment: widget.navigateToAssignment),
            const ShiftsView(),
            StaffProfileView(navigateToSplash: widget.navigateToSplash),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        enableFeedback: true,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.qr_code_scanner_outlined),
            activeIcon: const Icon(Icons.qr_code_scanner_rounded),
            tooltip: t.staff.home.bottom_nav.scan,
            label: t.staff.home.bottom_nav.scan,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.access_time_rounded),
            activeIcon: const Icon(Icons.access_time_filled_rounded),
            tooltip: t.staff.home.bottom_nav.shifts,
            label: t.staff.home.bottom_nav.shifts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_rounded),
            activeIcon: const Icon(Icons.person_rounded),
            tooltip: t.staff.home.bottom_nav.profile,
            label: t.staff.home.bottom_nav.profile,
          ),
        ],
      ),
    );
  }
}
