import 'package:flutter/material.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weight', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Weight',
                suffixText: 'kg',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
              ),
              style: TextStyle(color: colors.onSurface),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                debugPrint(_weightController.text);
              },
              child: const Text('Save weight'),
            ),
          ],
        ),
      ),
    );
  }
}
