// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_reading.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodPressureReadingAdapter extends TypeAdapter<BloodPressureReading> {
  @override
  final int typeId = 0;

  @override
  BloodPressureReading read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodPressureReading(
      systolic: fields[0] as int,
      diastolic: fields[1] as int,
      pulse: fields[2] as int,
      timestamp: fields[3] as DateTime,
      note: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BloodPressureReading obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.systolic)
      ..writeByte(1)
      ..write(obj.diastolic)
      ..writeByte(2)
      ..write(obj.pulse)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureReadingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
