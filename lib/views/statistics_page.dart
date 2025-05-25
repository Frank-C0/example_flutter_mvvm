import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: const Center(
        child: Text('Estadísticas (próximamente)', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
