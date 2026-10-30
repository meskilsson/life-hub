import 'package:flutter/material.dart';

import '../../ui/core/widgets/animals/animal.dart';
import '../../ui/core/widgets/weight/animal_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const animals = [
      Animal(
        name: 'Polar Bear',
        imagePath: 'assets/images/polarbear.png',
        description: 'En isbjörn',
      ),
      Animal(
        name: 'Mar Bear',
        imagePath: 'assets/images/bearlol.png',
        description: 'En Mar björn',
      ),
      Animal(
        name: 'Test1 Bear',
        imagePath: 'https://picsum.photos/id/237/400/300',
        description: 'En test björn',
      ),
      Animal(
        name: 'Test2 Bear',
        imagePath: 'https://picsum.photos/id/1025/400/300',
        description: 'En andra björn',
      ),
      Animal(
        name: 'Test3 Bear',
        imagePath: 'https://picsum.photos/id/200/400/300',
        description: 'En tredje björn',
      ),
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final minHeight = constraints.maxHeight > 32
              ? constraints.maxHeight - 32
              : 0.0;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    for (final animal in animals)
                      SizedBox(
                        width: 260,
                        child: AnimalCard(
                          animal: animal,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(animal.name)),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
