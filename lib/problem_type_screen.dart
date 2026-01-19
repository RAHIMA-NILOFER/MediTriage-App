import 'package:flutter/material.dart';

class ProblemTypeScreen extends StatelessWidget {
  final Function(String) onSelect;

  const ProblemTypeScreen({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Heart',
      'Lung',
      'Bone',
      'Muscle',
      'Teeth',
      'Skin',
      'Infection',
      'General',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Problem Type')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) => InkWell(
          onTap: () {
            onSelect(items[i]);
            Navigator.pop(context);
          },
          child: Card(
            child: Center(
              child: Text(
                items[i],
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
