import 'package:hive/hive.dart';

part 'blood_pressure_reading.g.dart';


@HiveType(typeId: 0)
class BloodPressureReading extends HiveObject {
  @HiveField(0)
  final int systolic;

  @HiveField(1)
  final int diastolic;

  @HiveField(2)
  final int pulse;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final String? note;

  BloodPressureReading({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.timestamp,
    required this.note,
  });
}
