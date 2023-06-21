import 'package:askida_yemek/model/yemek_model.dart';
import 'package:hive/hive.dart';

part 'restorant_model.g.dart';

@HiveType(typeId: 1)
class RestorantModel {
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
  String adres;
  @HiveField(7)
  String fotograf;
  @HiveField(8)
  String parola;
  @HiveField(9)
  List<YemekModel> yemekListe;
  RestorantModel({
    required this.id,
    required this.ad,
    required this.il,
    required this.ilce,
    required this.telefon,
    required this.mail,
    required this.adres,
    required this.fotograf,
    required this.parola,
    required this.yemekListe,
  });
}
