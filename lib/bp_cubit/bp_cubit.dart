import 'package:bloc/bloc.dart';
import 'package:bp_tacking/models/blood_pressure_reading.dart';
import 'package:bp_tacking/repositories/database_repository.dart';
import 'package:equatable/equatable.dart';

part 'bp_state.dart';

class BPCubit extends Cubit<BPState> {

  final DatabaseRepository repository;

  BPCubit(this.repository) : super(BPState(readings: repository.getReadings()));

  void addReading(BloodPressureReading reading) async {
    await repository.addReading(reading);
    emit(state.copyWith(readings: repository.getReadings()));
  }

  // NEW - In your BPCubit
  void deleteReading(dynamic key) async {
    await repository.deleteReading(key);
    emit(state.copyWith(readings: repository.getReadings()));
  }

  void clearAll() async {
    await repository.clearReadings();
    emit(state.copyWith(readings: repository.getReadings()));
  }
}
