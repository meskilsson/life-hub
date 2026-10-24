import 'package:flutter/material.dart';

import '../pages/home_page/home_page.dart';
import '../pages/weight_page/weight_page.dart';
import '../pages/sleep_hours_page/sleep_hours_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 0;

  final List<Widget> pages = const [HomePage(), WeightPage(), SleepHoursPage()];

  Widget get selectedPage => pages[selectedIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Hub'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedIndex = 0;
              });
            },
            child: Text(
              'Home',
              style: TextStyle(
                fontWeight: selectedIndex == 0
                    ? FontWeight.bold
                    : FontWeight.normal,
                decoration: selectedIndex == 0
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            child: Text(
              'Weight',
              style: TextStyle(
                fontWeight: selectedIndex == 1
                    ? FontWeight.bold
                    : FontWeight.normal,
                decoration: selectedIndex == 1
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedIndex = 2;
              });
            },
            child: Text(
              'Sleep',
              style: TextStyle(
                fontWeight: selectedIndex == 2
                    ? FontWeight.bold
                    : FontWeight.normal,
                decoration: selectedIndex == 2
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: IndexedStack(index: selectedIndex, children: pages),
    );
  }
}
