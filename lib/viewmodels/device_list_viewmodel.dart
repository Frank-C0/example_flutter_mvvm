import 'package:flutter/material.dart';
import '../models/device.dart';
import '../services/device_service.dart';

class DeviceListViewModel extends ChangeNotifier {
  final DeviceService _service = DeviceService();
  List<Device> _devices = [];

  List<Device> get devices => _devices;

  DeviceListViewModel() {
    fetchDevices();
  }

  void fetchDevices() {
    _devices = _service.getDevices();
    notifyListeners();
  }
}
