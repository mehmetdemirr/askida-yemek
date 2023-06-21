// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'yemek_model.g.dart';

@HiveType(typeId: 2)
class YemekModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String yemekAd;
  @HiveField(2)
  double yemekFiyat;
  @HiveField(3)
  String yemekFotograf;
  @HiveField(4)
  int askidaYemek;
  YemekModel({
    required this.id,
    required this.yemekAd,
    required this.yemekFiyat,
    required this.askidaYemek,
    required this.yemekFotograf,
  });
}
