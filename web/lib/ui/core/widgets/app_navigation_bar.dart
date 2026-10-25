import 'package:flutter/material.dart';

import 'nav_link.dart';

class AppNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Size get preferredSize => const Size.fromHeight(72);
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      toolbarHeight: preferredSize.height,
      titleSpacing: 24,
      actionsPadding: const EdgeInsets.only(right: 24),
      title: const Text('Life Hub'),
      shape: Border(bottom: BorderSide(color: colors.outlineVariant, width: 1)),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            NavLink(
              label: 'Home',
              isSelected: selectedIndex == 0,
              onPressed: () {
                onDestinationSelected(0);
              },
            ),
            NavLink(
              label: 'Weight',
              isSelected: selectedIndex == 1,
              onPressed: () {
                onDestinationSelected(1);
              },
            ),
            NavLink(
              label: 'Sleep',
              isSelected: selectedIndex == 2,
              onPressed: () {
                onDestinationSelected(2);
              },
            ),
          ],
        ),
      ],
    );
  }
}
