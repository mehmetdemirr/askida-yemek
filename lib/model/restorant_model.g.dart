// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restorant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestorantModelAdapter extends TypeAdapter<RestorantModel> {
  @override
  final int typeId = 1;

  @override
  RestorantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestorantModel(
      id: fields[0] as String,
      ad: fields[1] as String,
      il: fields[2] as String,
      ilce: fields[3] as String,
      telefon: fields[4] as String,
      mail: fields[5] as String,
      adres: fields[6] as String,
      fotograf: fields[7] as String,
      parola: fields[8] as String,
      yemekListe: (fields[9] as List).cast<YemekModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RestorantModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ad)
      ..writeByte(2)
      ..write(obj.il)
      ..writeByte(3)
      ..write(obj.ilce)
      ..writeByte(4)
      ..write(obj.telefon)
      ..writeByte(5)
      ..write(obj.mail)
      ..writeByte(6)
      ..write(obj.adres)
      ..writeByte(7)
      ..write(obj.fotograf)
      ..writeByte(8)
      ..write(obj.parola)
      ..writeByte(9)
      ..write(obj.yemekListe);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestorantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
