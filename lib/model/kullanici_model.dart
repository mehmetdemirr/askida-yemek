// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'kullanici_model.g.dart';

@HiveType(typeId: 0)
class KullaniciModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String ad;
  @HiveField(2)
  String il;
  @HiveField(3)
  String ilce;
  @HiveField(4)
  String telefon;
  @HiveField(5)
  String mail;
  @HiveField(6)
  String parola;
  KullaniciModel({
    required this.id,
    required this.ad,
    required this.il,
    required this.ilce,
    required this.telefon,
    required this.mail,
    required this.parola,
  });
}
