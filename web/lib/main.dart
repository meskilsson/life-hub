import 'package:flutter/material.dart';
import 'package:life_hub/routing/router.dart';

import 'ui/core/theme/app_theme.dart';

import 'ui/app_shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Hub',
      theme: AppTheme.light,
      home: AppShell(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
