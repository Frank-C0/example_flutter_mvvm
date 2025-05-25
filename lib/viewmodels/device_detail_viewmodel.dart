import 'package:flutter/material.dart';
import '../models/sensor.dart';
import '../services/device_service.dart';

class DeviceDetailViewModel extends ChangeNotifier {
  final DeviceService _service = DeviceService();
  final String deviceId;
  List<Sensor> sensors = [];
  Stream<List<Sensor>>? _sensorStream;
  Stream<List<Sensor>>? get sensorStream => _sensorStream;

  DeviceDetailViewModel({required this.deviceId}) {
    _sensorStream = _service.getSensorData(deviceId);
    _sensorStream!.listen((data) {
      sensors = data;
      notifyListeners();
    });
  }
}
