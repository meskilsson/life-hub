import 'package:flutter/material.dart';
import 'package:life_hub/routing/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.weight);
              },
              child: const Text('Weight'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.sleepHours);
              },
              child: const Text('Sleep hours'),
            ),
          ],
        ),
      ),
    );
  }
}
