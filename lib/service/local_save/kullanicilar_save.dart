import 'package:askida_yemek/model/kullanici_model.dart';
import 'package:askida_yemek/model/restorant_model.dart';
import 'package:askida_yemek/utils/constants/local_key_items.dart';
import 'package:askida_yemek/utils/functions/print_islem.dart';
import 'package:hive/hive.dart';

abstract class ILocalSave {
  void delete(int kullaniciModel);
  void clear();
  void update(KullaniciModel kullaniciModel);
  void insert(KullaniciModel kullaniciModel);
  List<KullaniciModel> read();
}

class LocalSaveKullanici implements ILocalSave {
  @override
  void delete(int kullaniciModel) async {
    var box = Hive.box<RestorantModel>(LocalKeyItem.kullanici.name);
    box.deleteAt(kullaniciModel);
    printf("silindi");
  }

  @override
  void clear() {
    var box = Hive.box<KullaniciModel>(LocalKeyItem.kullanici.name);
    box.clear();
    //print("hepsi silindi");
  }

  @override
  List<KullaniciModel> read() {
    var box = Hive.box<KullaniciModel>(LocalKeyItem.kullanici.name);
    List<KullaniciModel> liste = [];
    for (KullaniciModel i in box.values) {
      liste.add(i);
    }
    return liste;
  }

  @override
  void update(KullaniciModel kullaniciModel) {
    var box = Hive.box<KullaniciModel>(LocalKeyItem.kullanici.name);
    box.put(kullaniciModel.id, kullaniciModel);
    //print("güncellendi");
  }

  @override
  void insert(KullaniciModel kullaniciModel) async {
    var box = Hive.box<KullaniciModel>(LocalKeyItem.kullanici.name);
    box.put(kullaniciModel.id, kullaniciModel);
    //print("eklendi ${medication.createTime.id()}");
  }
}
