import 'package:flutter/material.dart';
import 'package:life_hub/data/models/weight_entry.dart';
import 'package:life_hub/ui/core/widgets/cards/base_card.dart';

class WeightCard extends StatelessWidget {
  const WeightCard({super.key, required this.weight, this.onDelete});

  final WeightEntry weight;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final date = weight.recordedAt.toLocal();

    final colors = Theme.of(context).colorScheme;

    return SelectionArea(
      child: BaseCard(
        variant: CardVariant.secondary,
        crossAxisAlignment: CrossAxisAlignment.start,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text('${date.day}/${date.month} ${date.year}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${weight.weightKg} kg'),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Radera vikt',
                  color: colors.error,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
