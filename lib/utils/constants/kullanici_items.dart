enum KullaniciItem {
  kullanici,
  restorant,
}

extension KullaniciItems on KullaniciItem {
  String str() {
    switch (this) {
      case KullaniciItem.kullanici:
        return "kullanıcı";
      case KullaniciItem.restorant:
        return "restorant";
    }
  }
}
