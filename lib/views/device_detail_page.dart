import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/device_detail_viewmodel.dart';
import '../models/sensor.dart';
import 'sensor_chart_page.dart';

class DeviceDetailPage extends StatelessWidget {
  final String deviceId;
  final String deviceName;
  const DeviceDetailPage({super.key, required this.deviceId, required this.deviceName});

  IconData _getIcon(SensorType type) {
    switch (type) {
      case SensorType.temperature:
        return Icons.thermostat;
      case SensorType.humidity:
        return Icons.water_drop;
    }
  }

  String _getLabel(SensorType type) {
    switch (type) {
      case SensorType.temperature:
        return 'Temperatura';
      case SensorType.humidity:
        return 'Humedad';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeviceDetailViewModel(deviceId: deviceId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(deviceName),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Consumer<DeviceDetailViewModel>(
          builder: (context, vm, child) {
            return Container(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: vm.sensors.map((sensor) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(_getIcon(sensor.type), color: Theme.of(context).colorScheme.primary, size: 32),
                      title: Text(_getLabel(sensor.type), style: Theme.of(context).textTheme.titleMedium),
                      trailing: Text(sensor.value.toStringAsFixed(1), style: Theme.of(context).textTheme.titleLarge),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: Provider.of<DeviceDetailViewModel>(context, listen: false),
                              child: SensorChartPage(
                                sensorType: sensor.type,
                                deviceName: deviceName,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
