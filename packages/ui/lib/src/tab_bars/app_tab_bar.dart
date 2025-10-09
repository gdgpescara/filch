import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum _TabBarStyle { primary, secondary }

/// Custom TabBar widget with different styling options
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar._(
    this._style, {
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.onTap,
    this.physics,
    this.padding,
    this.tabAlignment,
  });

  /// Primary TabBar with trapezoidal indicator (like buttons)
  const AppTabBar.primary({
    Key? key,
    required List<Widget> tabs,
    TabController? controller,
    bool isScrollable = false,
    ValueChanged<int>? onTap,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    TabAlignment? tabAlignment,
  }) : this._(
         _TabBarStyle.primary,
         key: key,
         tabs: tabs,
         controller: controller,
         isScrollable: isScrollable,
         onTap: onTap,
         physics: physics,
         padding: padding,
         tabAlignment: tabAlignment,
       );

  /// Secondary TabBar with standard underline indicator
  const AppTabBar.secondary({
    Key? key,
    required List<Widget> tabs,
    TabController? controller,
    bool isScrollable = false,
    ValueChanged<int>? onTap,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding,
    TabAlignment? tabAlignment,
  }) : this._(
         _TabBarStyle.secondary,
         key: key,
         tabs: tabs,
         controller: controller,
         isScrollable: isScrollable,
         onTap: onTap,
         physics: physics,
         padding: padding,
         tabAlignment: tabAlignment,
       );

  final List<Widget> tabs;
  final _TabBarStyle _style;
  final TabController? controller;
  final bool isScrollable;
  final ValueChanged<int>? onTap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final TabAlignment? tabAlignment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tabBarTheme = switch (_style) {
      _TabBarStyle.primary => primaryTabBarTheme(colorScheme),
      _TabBarStyle.secondary => secondaryTabBarTheme(colorScheme),
    };

    return Theme(
      data: Theme.of(context).copyWith(tabBarTheme: tabBarTheme),
      child: TabBar(
        tabs: tabs,
        controller: controller,
        isScrollable: isScrollable,
        onTap: onTap,
        physics: physics,
        padding: padding,
        tabAlignment: tabAlignment,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
