// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RelationshipAdapter extends TypeAdapter<Relationship> {
  @override
  final int typeId = 1;

  @override
  Relationship read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Relationship(
      name: fields[0] as String,
      relation: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Relationship obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.relation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RelationshipAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
