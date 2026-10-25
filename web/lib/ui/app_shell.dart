import 'package:flutter/material.dart';

import '../pages/home_page/home_page.dart';
import '../pages/weight_page/weight_page.dart';
import '../pages/sleep_hours_page/sleep_hours_page.dart';
import '../ui/core/widgets/app_navigation_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 0;

  final List<Widget> pages = const [HomePage(), WeightPage(), SleepHoursPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppNavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
    );
  }
}
