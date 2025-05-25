import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/sensor.dart';
import '../services/device_service.dart';

class DeviceDetailViewModel extends ChangeNotifier {
  final DeviceService _service = DeviceService();
  final String deviceId;
  List<Sensor> sensors = [];
  Map<SensorType, List<Sensor>> sensorHistory = {
    SensorType.temperature: [],
    SensorType.humidity: [],
  };
  final Duration historyWindow = const Duration(seconds: 30);
  Stream<List<Sensor>>? _sensorStream;
  Stream<List<Sensor>>? get sensorStream => _sensorStream;

  DeviceDetailViewModel({required this.deviceId}) {
    _sensorStream = _service.getSensorData(deviceId);
    _sensorStream!.listen((data) {
      sensors = data;
      final now = DateTime.now();
      for (var sensor in data) {
        final list = sensorHistory[sensor.type]!;
        list.add(sensor);
        // Mantener solo los datos dentro de la ventana de tiempo
        list.removeWhere((s) => now.difference(s.timestamp) > historyWindow);
      }
      notifyListeners();
    });
  }
}
