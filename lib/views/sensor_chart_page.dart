import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../viewmodels/device_detail_viewmodel.dart';
import '../models/sensor.dart';

class SensorChartPage extends StatelessWidget {
  final SensorType sensorType;
  final String deviceName;
  const SensorChartPage({super.key, required this.sensorType, required this.deviceName});

  String _getLabel(SensorType type) {
    switch (type) {
      case SensorType.temperature:
        return 'Temperatura (°C)';
      case SensorType.humidity:
        return 'Humedad (%)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${_getLabel(sensorType)} - $deviceName')),
      body: Consumer<DeviceDetailViewModel>(
        builder: (context, vm, child) {
          final history = vm.sensorHistory[sensorType] ?? [];
          if (history.isEmpty) {
            return const Center(child: Text('Sin datos'));
          }
          // Ventana de tiempo en segundos
          final windowSeconds = vm.historyWindow.inSeconds - 5;
          final now = DateTime.now();
          // Solo los datos dentro de la ventana
          final visible = history.where((s) => now.difference(s.timestamp).inSeconds <= windowSeconds).toList();
          if (visible.isEmpty) {
            return const Center(child: Text('Sin datos recientes'));
          }
          // Normaliza el eje X: 0 = inicio de la ventana, windowSeconds = ahora
          final minY = visible.map((s) => s.value).reduce((a, b) => a < b ? a : b) - 2;
          final maxY = visible.map((s) => s.value).reduce((a, b) => a > b ? a : b) + 2;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(_getLabel(sensorType), style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      minY: minY,
                      maxY: maxY,
                      minX: 0,
                      maxX: windowSeconds.toDouble(),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            for (var s in visible)
                              FlSpot(
                                windowSeconds - now.difference(s.timestamp).inMilliseconds / 1000.0,
                                s.value,
                              ),
                          ],
                          isCurved: false,
                          color: Theme.of(context).colorScheme.primary,
                          barWidth: 3,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Theme.of(context).colorScheme.primary,
                                strokeWidth: 1.5,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              final secondsAgo = windowSeconds - value.toInt();
                              return Text('-${secondsAgo}s', style: const TextStyle(fontSize: 10));
                            },
                            interval: 5,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                    ),
                    duration: Duration.zero, // Sin animación para evitar pulsaciones
                  ),
                ),
                const SizedBox(height: 16),
                Text('Actual: ${visible.isNotEmpty ? visible.last.value.toStringAsFixed(1) : '-'}',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
