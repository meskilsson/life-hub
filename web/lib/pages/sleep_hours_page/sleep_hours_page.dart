import 'package:flutter/material.dart';
import 'package:life_hub/data/models/sleep_hours_entry.dart';
import 'package:life_hub/data/services/sleep_hours_api_serivce.dart';
import 'package:life_hub/ui/core/widgets/cards/base_card.dart';

class SleepHoursPage extends StatefulWidget {
  const SleepHoursPage({super.key});

  @override
  State<SleepHoursPage> createState() => _SleepHoursPageState();
}

class _SleepHoursPageState extends State<SleepHoursPage> {
  final _sleepHoursController = TextEditingController();
  bool _isSaving = false;
  late Future<List<SleepHoursEntry>> _sleepHoursFuture;

  @override
  void initState() {
    super.initState();
    _sleepHoursFuture = getSleepHours();
  }

  @override
  void dispose() {
    _sleepHoursController.dispose();
    super.dispose();
  }

  Future<void> _saveSleepHours() async {
    final sleepHours = double.tryParse(
      _sleepHoursController.text.trim().replaceAll(',', '.'),
    );

    if (sleepHours == null || !sleepHours.isFinite || sleepHours <= 0) {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: const Text('Ange ett giltigt antal timmar över 0.'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Stäng'),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      _isSaving = true;
    });

    try {
      final entry = await createSleepHours(
        sleepHours: sleepHours,
        recordedAt: DateTime.now(),
      );

      if (!mounted) return;

      setState(() {
        _sleepHoursFuture = getSleepHours();
      });

      _sleepHoursController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${entry.sleepHours} timmar sparades!')),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kunde inte spara sömn, försök igen!')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 500,
                  height: 400,
                  child: BaseCard(
                    title: 'Sömn',
                    variant: CardVariant.secondary,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 400,
                                  ),
                                  child: SizedBox(
                                    height: 56,
                                    child: TextField(
                                      controller: _sleepHoursController,
                                      expands: true,
                                      minLines: null,
                                      maxLines: null,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: const InputDecoration(
                                        labelText: 'Hours',
                                        suffixText: 'h',
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: _isSaving ? null : _saveSleepHours,
                                  child: Text(
                                    _isSaving ? 'Saving...' : 'Save hours',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Expanded(
                            child: FutureBuilder(
                              future: _sleepHoursFuture,
                              builder: (context, snapshot) {
                                final textTheme = Theme.of(context).textTheme;
                                final colors = Theme.of(context).colorScheme;
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Kunde inte hämta sömntimmar'),
                                  );
                                }

                                final sleep = snapshot.data ?? [];

                                if (sleep.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Inga sömntimmar registrerade ännu',
                                    ),
                                  );
                                }

                                return SingleChildScrollView(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      for (final entry in sleep)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          child: Card(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    MaterialLocalizations.of(
                                                      context,
                                                    ).formatMediumDate(
                                                      entry.recordedAt
                                                          .toLocal(),
                                                    ),
                                                    style: textTheme
                                                        .headlineLarge
                                                        ?.copyWith(
                                                          color: colors.primary,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    '${entry.sleepHours} timmar',
                                                    style: textTheme.titleMedium
                                                        ?.copyWith(
                                                          color:
                                                              colors.secondary,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
