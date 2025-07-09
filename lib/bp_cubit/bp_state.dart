part of 'bp_cubit.dart';

class BPState extends Equatable {
  const BPState({required this.readings});

  final List<BloodPressureReading> readings;



  @override
  List<Object?> get props => [readings];

  BPState copyWith({
    List<BloodPressureReading>? readings,
  }) {
    return BPState(
      readings: readings ?? this.readings,
    );
  }
}