import 'package:bp_tacking/models/blood_pressure_reading.dart';
import 'package:hive/hive.dart';

class DatabaseRepository {

  final Box<BloodPressureReading> _box;

  DatabaseRepository(this._box);

  List<BloodPressureReading> getReadings() => _box.values.toList();

  Future<void> addReading(BloodPressureReading reading) => _box.add(reading);

  // In database_repository.dart
  Future<void> deleteReading(dynamic key) async {
    final box = Hive.box<BloodPressureReading>('readings');
    await box.delete(key);
  }

  Future<void> clearReadings() => _box.clear();

}