// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:askida_yemek/model/restorant_model.dart';
import 'package:askida_yemek/model/yemek_model.dart';

part 'sepet_model.g.dart';

@HiveType(typeId: 3)
class SepetModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  RestorantModel restorantModel;
  @HiveField(2)
  YemekModel yemekModel;
  SepetModel({
    required this.id,
    required this.restorantModel,
    required this.yemekModel,
  });
}
