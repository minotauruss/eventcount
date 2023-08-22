// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 0;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      fields[5] as String,
      fields[0] as String,
      fields[1] as String,
      (fields[2] as List).cast<DateTime>(),
      fields[4] as bool,
      (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._category)
      ..writeByte(2)
      ..write(obj._date)
      ..writeByte(3)
      ..write(obj._time)
      ..writeByte(4)
      ..write(obj._finished)
      ..writeByte(5)
      ..write(obj._id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
