// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catInfo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatInfoAdapter extends TypeAdapter<CatInfo> {
  @override
  final int typeId = 1;

  @override
  CatInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatInfo(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CatInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
