import 'package:flutter/material.dart';

class SleepHoursPage extends StatefulWidget {
  const SleepHoursPage({super.key});

  @override
  State<SleepHoursPage> createState() => _SleepHoursPageState();
}

class _SleepHoursPageState extends State<SleepHoursPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sleep hours')),
      body: Center(child: Text('Sleep Hours')),
    );
  }
}
