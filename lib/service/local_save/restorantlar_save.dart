import 'package:askida_yemek/model/restorant_model.dart';
import 'package:askida_yemek/utils/constants/local_key_items.dart';
import 'package:hive/hive.dart';

abstract class ILocalSave {
  void delete(int restorantModel);
  void clear();
  void update(RestorantModel restorantModel);
  void insert(RestorantModel restorantModel);
  List<RestorantModel> read();
}

class LocalSaveRestorant implements ILocalSave {
  @override
  void delete(int restorantModel) async {
    var box = Hive.box<RestorantModel>(LocalKeyItem.restorant.name);
    box.deleteAt(restorantModel);
    //print("silindi  ${medication.createTime.id()}");
  }

  @override
  void clear() {
    var box = Hive.box<RestorantModel>(LocalKeyItem.restorant.name);
    box.clear();
    //print("hepsi silindi");
  }

  @override
  List<RestorantModel> read() {
    var box = Hive.box<RestorantModel>(LocalKeyItem.restorant.name);
    List<RestorantModel> liste = [];
    for (RestorantModel i in box.values) {
      liste.add(i);
    }
    return liste;
  }

  @override
  void update(RestorantModel restorantModel) {
    var box = Hive.box<RestorantModel>(LocalKeyItem.restorant.name);
    box.put(restorantModel.mail, restorantModel);
    //print("güncellendi");
  }

  @override
  void insert(RestorantModel restorantModel) async {
    var box = Hive.box<RestorantModel>(LocalKeyItem.restorant.name);
    box.put(restorantModel.id, restorantModel);
    //print("eklendi ${medication.createTime.id()}");
  }
}
