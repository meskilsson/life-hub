import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NavLink extends StatelessWidget {
  const NavLink({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isSelected,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.text : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: AppColors.text,
          ),
        ),
      ),
    );
  }
}
