// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceRecordAdapter extends TypeAdapter<ServiceRecord> {
  @override
  final int typeId = 1;

  @override
  ServiceRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceRecord(
      id: fields[0] as String?,
      vehicleId: fields[1] as String,
      serviceDate: fields[2] as DateTime,
      serviceType: fields[3] as String,
      notes: fields[4] as String,
      cost: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vehicleId)
      ..writeByte(2)
      ..write(obj.serviceDate)
      ..writeByte(3)
      ..write(obj.serviceType)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.cost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
