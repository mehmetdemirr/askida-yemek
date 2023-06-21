// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sepet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SepetModelAdapter extends TypeAdapter<SepetModel> {
  @override
  final int typeId = 3;

  @override
  SepetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SepetModel(
      id: fields[0] as int,
      restorantModel: fields[1] as RestorantModel,
      yemekModel: fields[2] as YemekModel,
    );
  }

  @override
  void write(BinaryWriter writer, SepetModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.restorantModel)
      ..writeByte(2)
      ..write(obj.yemekModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SepetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
