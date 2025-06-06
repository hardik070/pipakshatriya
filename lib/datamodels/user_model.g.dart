// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      name: fields[0] as String,
      profilePic: fields[1] as String,
      fatherName: fields[2] as String,
      email: fields[3] as String,
      phoneNumber: (fields[4] as List).cast<String>(),
      gotra: fields[5] as String,
      actualAddress: fields[6] as String,
      relationships: (fields[7] as List)
          .map((dynamic e) => (e as Map).cast<String, String>())
          .toList(),
      currentAddress: fields[8] as String,
      userId: fields[9] as String,
      subDocId: fields[10] as String,
    )
      ..fachedUsersCache = (fields[11] as List?)?.cast<FachedUsersCache>()
      ..fachedUsersKeys = (fields[12] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.profilePic)
      ..writeByte(2)
      ..write(obj.fatherName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.gotra)
      ..writeByte(6)
      ..write(obj.actualAddress)
      ..writeByte(7)
      ..write(obj.relationships)
      ..writeByte(8)
      ..write(obj.currentAddress)
      ..writeByte(9)
      ..write(obj.userId)
      ..writeByte(10)
      ..write(obj.subDocId)
      ..writeByte(11)
      ..write(obj.fachedUsersCache)
      ..writeByte(12)
      ..write(obj.fachedUsersKeys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
