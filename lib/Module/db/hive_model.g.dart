// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpotAdapter extends TypeAdapter<Spot> {
  @override
  final int typeId = 0;

  @override
  Spot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spot(
      placeName: fields[0] as String,
      memo: fields[1] as String?,
      imagePath: (fields[2] as List?)?.cast<String>(),
      latitude: fields[3] as double,
      longitude: fields[4] as double,
    )..createdAt = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Spot obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.placeName)
      ..writeByte(1)
      ..write(obj.memo)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
