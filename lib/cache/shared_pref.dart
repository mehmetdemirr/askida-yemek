import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> setLogin(bool login) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedItem.login.str(), login);
  }

  static Future<bool> getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedItem.login.str()) ?? false;
  }

  static Future<void> setKullaniciCesit(int kullanici) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SharedItem.kullaniciCesit.str(), kullanici);
  }

  static Future<int> getKullaniciCesit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedItem.kullaniciCesit.str()) ?? -1;
  }

  static Future<void> setData(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedItem.userData.str(), data);
  }

  static Future<String> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedItem.userData.str()) ?? "";
  }
}

enum SharedItem {
  login,
  userData,
  kullaniciCesit,
}

extension SharedItems on SharedItem {
  String str() {
    return switch (this) {
      SharedItem.login => "login",
      SharedItem.userData => "id",
      // restoran => 1  kullanıcı =>2
      SharedItem.kullaniciCesit => "kullaniciCesit",
    };
  }
}
