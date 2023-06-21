import 'package:askida_yemek/model/sepet_model.dart';
import 'package:askida_yemek/utils/constants/local_key_items.dart';
import 'package:askida_yemek/utils/functions/print_islem.dart';
import 'package:hive/hive.dart';

abstract class ILocalSave {
  void delete(int yemekModel);
  void clear();
  void update(SepetModel yemekModel);
  void insert(SepetModel yemekModel);
  List<SepetModel> read();
}

class LocalSaveSepet implements ILocalSave {
  @override
  void delete(int yemekModel) async {
    var box = Hive.box<SepetModel>(LocalKeyItem.sepet.name);
    box.deleteAt(yemekModel);
    printf("silindi");
  }

  @override
  void clear() {
    var box = Hive.box<SepetModel>(LocalKeyItem.sepet.name);
    box.clear();
    //print("hepsi silindi");
  }

  @override
  List<SepetModel> read() {
    var box = Hive.box<SepetModel>(LocalKeyItem.sepet.name);
    List<SepetModel> liste = [];
    for (SepetModel i in box.values) {
      liste.add(i);
    }
    return liste;
  }

  @override
  void update(SepetModel yemekModel) {
    var box = Hive.box<SepetModel>(LocalKeyItem.sepet.name);
    box.put(yemekModel.id, yemekModel);
    //print("güncellendi");
  }

  @override
  void insert(SepetModel yemekModel) async {
    var box = Hive.box<SepetModel>(LocalKeyItem.sepet.name);
    box.add(yemekModel);
    //print("eklendi ${medication.createTime.id()}");
  }
}
