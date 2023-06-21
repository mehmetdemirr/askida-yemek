import 'package:askida_yemek/screen/home_screen.dart';
import 'package:askida_yemek/utils/constants/kullanici_items.dart';
import 'package:flutter/material.dart';

class OdemeBasarili extends StatefulWidget {
  const OdemeBasarili({super.key});
  @override
  State<OdemeBasarili> createState() => _OdemeBasariliState();
}

class _OdemeBasariliState extends State<OdemeBasarili> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/tik.png"),
            Text(
              "Ödeme Başarılı !",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(
                      secim: KullaniciItem.kullanici,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                "Ana sayfaya dönmek için basın",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
