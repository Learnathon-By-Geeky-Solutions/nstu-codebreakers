import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    if (index >= 0 && index < navigationShell.route.branches.length) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    } else {
      if (kDebugMode) {
        debugPrint('Invalid branch index: $index');
      }
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationShell.currentIndex,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.house_outlined),
          label: 'Home',
          activeIcon: Icon(Icons.house_rounded),
          tooltip: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outlined,
          ),
          label: 'Profile',
          activeIcon: Icon(
            Icons.person_rounded,
          ),
          tooltip: 'Profile',
        ),
      ],
      onTap: _goBranch,
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: navigationShell,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
