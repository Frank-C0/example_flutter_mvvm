enum SensorType { temperature, humidity }

class Sensor {
  final SensorType type;
  double value;

  Sensor({required this.type, required this.value});
}
