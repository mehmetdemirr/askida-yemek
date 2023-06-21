// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yemek_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YemekModelAdapter extends TypeAdapter<YemekModel> {
  @override
  final int typeId = 2;

  @override
  YemekModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YemekModel(
      id: fields[0] as int,
      yemekAd: fields[1] as String,
      yemekFiyat: fields[2] as double,
      askidaYemek: fields[4] as int,
      yemekFotograf: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, YemekModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.yemekAd)
      ..writeByte(2)
      ..write(obj.yemekFiyat)
      ..writeByte(3)
      ..write(obj.yemekFotograf)
      ..writeByte(4)
      ..write(obj.askidaYemek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YemekModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
