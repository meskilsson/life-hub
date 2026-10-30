import 'package:flutter/material.dart';
import 'package:life_hub/ui/core/widgets/animals/animal.dart';

import '../cards/dashboard_card.dart';

class AnimalCard extends StatelessWidget {
  const AnimalCard({super.key, required this.animal, this.onTap});

  final Animal animal;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: DashboardCard(
        title: animal.name,
        onTap: onTap,
        widget: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),

              child: Image(
                image:
                    animal.imagePath.startsWith('https://') ||
                        animal.imagePath.startsWith('http://')
                    ? NetworkImage(animal.imagePath)
                    : AssetImage(animal.imagePath),
                height: 150,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),

            Text(animal.description ?? "Ingen beskrivning ännu"),
          ],
        ),
      ),
    );
  }
}
