import 'dart:collection';

enum SensorType { temperature, humidity }

class Sensor {
  final SensorType type;
  double value;
  DateTime timestamp;

  Sensor({required this.type, required this.value, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}
