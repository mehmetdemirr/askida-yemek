import 'package:askida_yemek/cache/shared_pref.dart';
import 'package:askida_yemek/screen/home_screen.dart';
import 'package:askida_yemek/screen/kullanici_secim_screen.dart';
import 'package:askida_yemek/utils/constants/kullanici_items.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getKullaniciCesit() async {
    int secim = await SharedPref.getKullaniciCesit();
    if (secim == 1) {
      kullaniciCesit = KullaniciItem.restorant;
    } else {
      kullaniciCesit = KullaniciItem.kullanici;
    }
  }

  bool login = false;
  late KullaniciItem kullaniciCesit;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      login = await SharedPref.getLogin();
      await getKullaniciCesit();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => login
                ? HomeScreen(
                    secim: kullaniciCesit,
                  )
                : const KullaniciSecim(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/askida_yemek.png"),
          ],
        ),
      ),
    );
  }
}
