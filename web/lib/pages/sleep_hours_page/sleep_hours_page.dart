import 'package:flutter/material.dart';
import 'package:life_hub/ui/core/widgets/cards/base_card.dart';

class SleepHoursPage extends StatefulWidget {
  const SleepHoursPage({super.key});

  @override
  State<SleepHoursPage> createState() => _SleepHoursPageState();
}

class _SleepHoursPageState extends State<SleepHoursPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: BaseCard()));
  }
}
