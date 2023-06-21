import 'package:askida_yemek/screen/kullanici/kullanici_kayitol_screen.dart';
import 'package:askida_yemek/screen/restoran/restoran_kayitol_screen.dart';
import 'package:askida_yemek/utils/constants/padding_items.dart';
import 'package:flutter/material.dart';

class KullaniciSecim extends StatefulWidget {
  const KullaniciSecim({super.key});
  @override
  State<KullaniciSecim> createState() => _KullaniciSecimState();
}

class _KullaniciSecimState extends State<KullaniciSecim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/images/yemek.png"),
            Text(
              "Lütfen Devam etmek için seçim yapınız !",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: PaddingItem.medium.str(),
              child: Text(
                "Restorantınız varsa bu seçeneği seçerek restorantızı sistemimize kaydedip askıda yemek kampanyasına destek olabilirsiniz.",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: PaddingItem.medium.str(),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestoranKayitol()),
                  );
                },
                child: const Text("Restoran ile Devam Et"),
              ),
            ),
            Padding(
              padding: PaddingItem.medium.str(),
              child: Text(
                "Kullanıcı ile devam ederseniz askıda yemek kampanyasını destekleyen tüm restorantarı görebilir, bu restorantlara askıda yemek bırakabilir ve yemeğe ihtiyacınız varsa buradan yemeğinizi yiyebilirsini. ",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: PaddingItem.medium.str(),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const KullaniciKayitol()),
                  );
                },
                child: const Text(
                  "Kullanıcı ile Devam Et",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
