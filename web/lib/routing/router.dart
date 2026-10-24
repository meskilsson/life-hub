import 'package:flutter/material.dart';

import '../pages/weight_page/weight_page.dart';
import '../pages/sleep_hours_page/sleep_hours_page.dart';

class AppRouter {
  static const weight = '/weight';
  static const sleepHours = '/sleepHours';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case weight:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const WeightPage(),
        );

      case sleepHours:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SleepHoursPage(),
        );

      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Page not found')),
            body: Center(child: const Text('This page does not exist.')),
          ),
        );
    }
  }
}
