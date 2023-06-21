// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kullanici_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KullaniciModelAdapter extends TypeAdapter<KullaniciModel> {
  @override
  final int typeId = 0;

  @override
  KullaniciModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KullaniciModel(
      id: fields[0] as String,
      ad: fields[1] as String,
      il: fields[2] as String,
      ilce: fields[3] as String,
      telefon: fields[4] as String,
      mail: fields[5] as String,
      parola: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KullaniciModel obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.parola);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KullaniciModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
