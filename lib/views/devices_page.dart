import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/device_list_viewmodel.dart';
import 'device_detail_page.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceListViewModel>(
      builder: (context, vm, child) {
        return Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: ListView.builder(
            itemCount: vm.devices.length,
            itemBuilder: (context, index) {
              final device = vm.devices[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.devices, size: 32),
                  title: Text(device.name, style: Theme.of(context).textTheme.titleMedium),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DeviceDetailPage(deviceId: device.id, deviceName: device.name),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
