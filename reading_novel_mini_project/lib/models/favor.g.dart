// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteAdapter extends TypeAdapter<Favorite> {
  @override
  final int typeId = 0;

  @override
  Favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorite(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      (fields[4] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Favorite obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.judul)
      ..writeByte(1)
      ..write(obj.sinopsis)
      ..writeByte(2)
      ..write(obj.gambar)
      ..writeByte(3)
      ..write(obj.genre)
      ..writeByte(4)
      ..write(obj.ch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
