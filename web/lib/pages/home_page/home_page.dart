import 'package:flutter/material.dart';

import '../../ui/core/widgets/cards/dashboard_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectionArea(
              child: DashboardCard(
                title: 'Polar bear',
                widget: Column(
                  children: [
                    SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(
                        image: AssetImage('assets/images/polarbear.png'),
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SelectionArea(
              child: DashboardCard(
                title: 'Mar bear',
                widget: Column(
                  children: [
                    SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image(
                        image: AssetImage('assets/images/bearlol.png'),
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
