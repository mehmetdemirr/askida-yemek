import 'package:askida_yemek/model/kullanici_model.dart';
import 'package:askida_yemek/model/restorant_model.dart';
import 'package:askida_yemek/model/sepet_model.dart';
import 'package:askida_yemek/model/yemek_model.dart';
import 'package:askida_yemek/screen/splash_screen.dart';
import 'package:askida_yemek/utils/constants/local_key_items.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("");
  Hive.registerAdapter(YemekModelAdapter());
  Hive.registerAdapter(RestorantModelAdapter());
  Hive.registerAdapter(KullaniciModelAdapter());
  Hive.registerAdapter(SepetModelAdapter());
  await Hive.openBox<KullaniciModel>(LocalKeyItem.kullanici.name);
  await Hive.openBox<RestorantModel>(LocalKeyItem.restorant.name);
  await Hive.openBox<SepetModel>(LocalKeyItem.sepet.name);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade200,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Color.fromARGB(100, 226, 24, 24),
          elevation: 15,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
              Color.fromARGB(100, 0, 35, 91),
            ),
          ),
        ),
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
          shadowColor: MaterialStatePropertyAll<Color>(
            Color.fromARGB(100, 0, 35, 91),
          ),
        )),
      ),
      home: const SplashScreen(),
    );
  }
}
