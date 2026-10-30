import 'package:flutter/material.dart';
import 'package:life_hub/data/services/weight_api_service.dart';
import 'package:life_hub/data/models/weight_entry.dart';
import 'package:life_hub/ui/core/widgets/cards/base_card.dart';
import 'package:life_hub/ui/core/widgets/cards/weight_card.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final _weightController = TextEditingController();

  bool _isSaving = false;
  late Future<List<WeightEntry>> _weightsFuture;

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _weightsFuture = getWeight();
  }

  Future<void> _deleteWeight(int id) async {
    try {
      await deleteWeight(id: id);

      if (!mounted) return;

      setState(() {
        _weightsFuture = getWeight();
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kunde inte radera vikten. Försök igen.')),
      );
    }
  }

  Future<void> _saveWeight() async {
    final weight = double.tryParse(
      _weightController.text.trim().replaceAll(',', '.'),
    );

    if (weight == null || !weight.isFinite || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ange en giltig vikt över 0.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final entry = await createWeight(
        weightKg: weight,
        recordedAt: DateTime.now(),
      );

      if (!mounted) return;

      setState(() {
        _weightsFuture = getWeight();
      });

      _weightController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${entry.weightKg} kg sparades!')));
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kunde inte spara vikten. Försök igen.')),
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
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 500,
                  height: 400,
                  child: BaseCard(
                    title: 'Vikt',
                    variant: CardVariant.standard,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    widget: Expanded(
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
                                      controller: _weightController,
                                      expands: true,
                                      minLines: null,
                                      maxLines: null,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: const InputDecoration(
                                        labelText: 'Weight',
                                        suffixText: 'kg',
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
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: _isSaving ? null : _saveWeight,
                                  child: Text(
                                    _isSaving ? 'Saving...' : 'Save Weight',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Expanded(
                            child: FutureBuilder<List<WeightEntry>>(
                              future: _weightsFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Kunde inte hämta vikterna.'),
                                  );
                                }

                                final weights = snapshot.data ?? [];

                                if (weights.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Inga vikter registrerade ännu.',
                                    ),
                                  );
                                }

                                return SingleChildScrollView(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      for (final entry in weights)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          child: WeightCard(
                                            weight: entry,
                                            onDelete: () =>
                                                _deleteWeight(entry.id),
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
