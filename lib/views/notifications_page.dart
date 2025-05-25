import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      'Dispositivo Sensor Invernadero 1 - Derecha: Temperatura alta detectada',
      'Dispositivo Sensor Invernadero 1 - Izquierda: Humedad baja detectada',
      'Dispositivo Sensor Invernadero 2',
    ];
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Color(0xFF6750A4)),
              title: Text(notifications[index]),
            ),
          );
        },
      ),
    );
  }
}
