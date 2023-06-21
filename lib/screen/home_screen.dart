import 'dart:io';

import 'package:askida_yemek/cache/shared_pref.dart';
import 'package:askida_yemek/model/restorant_model.dart';
import 'package:askida_yemek/model/yemek_model.dart';
import 'package:askida_yemek/screen/kullanici/restorant_detay_screen.dart';
import 'package:askida_yemek/screen/kullanici/sepet_screen.dart';
import 'package:askida_yemek/screen/kullanici_secim_screen.dart';
import 'package:askida_yemek/screen/restoran/yemek_ekle_screen.dart';
import 'package:askida_yemek/service/local_save/restorantlar_save.dart';
import 'package:askida_yemek/utils/constants/kullanici_items.dart';
import 'package:askida_yemek/utils/constants/padding_items.dart';
import 'package:askida_yemek/utils/extensions/screen_size.dart';
import 'package:askida_yemek/utils/functions/print_islem.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.secim});
  final KullaniciItem secim;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

RestorantModel? _restorantModel;

class _HomeScreenState extends State<HomeScreen> {
  String? imageUrl;
  late KullaniciItem kullaniciCesit;
  List<RestorantModel>? restorantListe;
  bool login = false;
  String userData = "boş";
  String userMail = "boş";
  RestorantModel defaultRestorant = RestorantModel(
    id: "",
    ad: "ad",
    il: "il",
    ilce: "ilce",
    telefon: "telefon",
    mail: "mail",
    adres: "adres",
    fotograf: "fotograf",
    parola: "parola",
    yemekListe: [
      YemekModel(
        id: 0,
        yemekAd: "yemekAd",
        yemekFiyat: 10,
        askidaYemek: 0,
        yemekFotograf: "",
      ),
      YemekModel(
        id: 0,
        yemekAd: "yemekAd",
        yemekFiyat: 10,
        askidaYemek: 4,
        yemekFotograf: "",
      ),
      YemekModel(
        id: 0,
        yemekAd: "yemekAd",
        yemekFiyat: 10,
        askidaYemek: 2,
        yemekFotograf: "",
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    kullaniciCesit = widget.secim;
    getLogin();
    if (login) {
      getKullaniciCesit();
    }
    getRestorantList();
    getUserData();

    Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      await getUserData().then((value) {
        userMail = userData.split(",").toList().first;
        printf("user mail : $userMail");
        for (var i in restorantListe ?? []) {
          //printf("restorant adı : ${i.ad}");
          if (i.mail == userMail) {
            _restorantModel = RestorantModel(
              id: i.id,
              ad: i.ad,
              il: i.il,
              ilce: i.ilce,
              telefon: i.telefon,
              mail: i.mail,
              adres: i.adres,
              fotograf: i.fotograf,
              parola: i.parola,
              yemekListe: i.yemekListe,
            );

            printf("geçerli restoran ad :${_restorantModel?.ad ?? ''}");
            printf("geçerli restornt mail :${_restorantModel?.mail ?? ''}");
            printf(
                "geçerli restornt yemek  :${_restorantModel?.yemekListe ?? ''}");
            for (var i in _restorantModel?.yemekListe ?? []) {
              printf("yemek ad : ${i.yemekAd}");
            }
            break;
          }
        }
      });
    });
  }

  Future<void> getRestorantList() async {
    restorantListe = LocalSaveRestorant().read();
  }

  Future<void> getLogin() async {
    login = await SharedPref.getLogin();
  }

  Future<void> getUserData() async {
    userData = (await SharedPref.getData());
  }

  Future<void> getKullaniciCesit() async {
    int secim = await SharedPref.getKullaniciCesit();
    if (secim == 1) {
      kullaniciCesit = KullaniciItem.restorant;
    } else if (secim == 2) {
      kullaniciCesit = KullaniciItem.kullanici;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ana Sayfa"),
        leading: kullaniciCesit == KullaniciItem.kullanici
            ? IconButton(
                onPressed: () async {
                  printf("sepete gidildi");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SepetScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              )
            : const SizedBox(),
        actions: [
          IconButton(
            onPressed: () async {
              printf("Çıkış yapıldı");
              await SharedPref.setLogin(false);
              await SharedPref.setKullaniciCesit(0);
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const KullaniciSecim(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: _kullaniciSecim(kullaniciCesit, restorantListe, _restorantModel),
      floatingActionButton: kullaniciCesit == KullaniciItem.restorant
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YemekEkleScreen(
                      restorantModel: _restorantModel ?? defaultRestorant,
                    ),
                  ),
                );
              },
              child: Image.asset("assets/images/yemek_ekle.png"),
            )
          : null,
    );
  }
}

Widget _kullaniciSecim(KullaniciItem kullaniciCesit,
    List<RestorantModel>? restorantListe, RestorantModel? restorant) {
  return kullaniciCesit == KullaniciItem.restorant
      ? const RestorantHomeScreen()
      : KullaniciHomeScreen(
          restorantListesi: restorantListe,
        );
}

class KullaniciHomeScreen extends StatefulWidget {
  const KullaniciHomeScreen({super.key, required this.restorantListesi});
  final List<RestorantModel>? restorantListesi;
  @override
  State<KullaniciHomeScreen> createState() => _KullaniciHomeScreenState();
}

class _KullaniciHomeScreenState extends State<KullaniciHomeScreen> {
  late final List<RestorantModel>? restorantListesi;
  List<int> askidaYemekListe = [];

  int askidaYemekSayisi = 0;
  @override
  void initState() {
    super.initState();
    restorantListesi = widget.restorantListesi;

    for (RestorantModel i in restorantListesi ?? []) {
      for (var i in i.yemekListe) {
        askidaYemekSayisi += i.askidaYemek;
      }
      askidaYemekListe.add(askidaYemekSayisi);
      askidaYemekSayisi = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return restorantListesi!.isNotEmpty
        ? ListView.builder(
            itemCount: restorantListesi?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestorantDetayScreen(
                        restorantModel: restorantListesi![index],
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: PaddingItem.medium.str(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: context.width,
                            child: Text(
                              "Restorant adı: ${restorantListesi?[index].ad}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(),
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(
                          width: context.width,
                          child: Text(
                            "Restorant İl: ${restorantListesi?[index].il}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: context.width,
                          child: Text(
                            "Restorant İlçe: ${restorantListesi?[index].ilce}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: context.width,
                          child: Text(
                            "Restorant Askıda yemek sayısı: ${askidaYemekListe[index]}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              "Askıda yemek bulunan restorant bulunamadı !",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
  }
}

class RestorantHomeScreen extends StatefulWidget {
  const RestorantHomeScreen({
    super.key,
  });
  @override
  State<RestorantHomeScreen> createState() => _RestorantHomeScreenState();
}

class _RestorantHomeScreenState extends State<RestorantHomeScreen> {
  int askidaYemekSayisi = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1)).then((value) async {
      for (YemekModel i in _restorantModel?.yemekListe ?? []) {
        askidaYemekSayisi += i.askidaYemek;
      }
      // print("askıda yemek : $askidaYemekSayisi");
      // print("yemek sayısı: ${restorantModel?.yemekListe.length}");
      // printf("restoran ad :${restorantModel?.ad}");
      // printf("restornt mail :${restorantModel?.mail}");
      // printf("restornt yemek  :${restorantModel?.yemekListe}");
      // for (var i in restorantModel?.yemekListe ?? []) {
      //   printf("yemek ad : ${i.yemekAd}");
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2)).then((value) {
      setState(() {});
    });
    return (_restorantModel?.yemekListe ?? []).isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: context.width / 2,
                  child: Image.asset("assets/images/askida_yemek.png"),
                ),
                Text(
                  "Restoranınızda yemek bulunamadı !",
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _restorantModel?.yemekListe.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: PaddingItem.medium.str(),
                    child: Row(
                      children: [
                        Padding(
                          padding: PaddingItem.small.str(),
                          child: Container(
                            child: _restorantModel
                                        ?.yemekListe[index].yemekFotograf ==
                                    ""
                                ? SizedBox(
                                    width: context.width / 6,
                                    height: context.width / 7,
                                    child: Icon(
                                      Icons.image,
                                      size: context.width / 7,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: SizedBox(
                                      width: context.width / 6,
                                      height: context.width / 7,
                                      child: Image.file(
                                        File(
                                          _restorantModel?.yemekListe[index]
                                                  .yemekFotograf ??
                                              "",
                                        ),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return SizedBox(
                                              width: context.width / 6,
                                              height: context.width / 7,
                                              child: Icon(
                                                Icons.image,
                                                size: context.width / 7,
                                              ));
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: context.width / 2,
                              child: Text(
                                "yemek ad : ${_restorantModel?.yemekListe[index].yemekAd}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: context.width / 2,
                              child: Text(
                                "yemek fiyat : ${_restorantModel?.yemekListe[index].yemekFiyat}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: context.width / 2,
                              child: Text(
                                "Askıda yemek sayısı : ${_restorantModel?.yemekListe[index].askidaYemek}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            if (_restorantModel != null) {
                              List<YemekModel> newYemekListesi =
                                  _restorantModel!.yemekListe;
                              if (newYemekListesi[index].askidaYemek > 0) {
                                newYemekListesi[index].askidaYemek -= 1;
                              }
                              RestorantModel newRestorantModel = RestorantModel(
                                id: _restorantModel?.id ?? "",
                                ad: _restorantModel!.yemekListe[index].yemekAd,
                                il: _restorantModel!.il,
                                ilce: _restorantModel!.ilce,
                                telefon: _restorantModel!.telefon,
                                mail: _restorantModel!.mail,
                                adres: _restorantModel!.adres,
                                fotograf: _restorantModel!.fotograf,
                                parola: _restorantModel!.parola,
                                yemekListe: newYemekListesi,
                              );
                              LocalSaveRestorant().update(newRestorantModel);
                            }
                          },
                          icon: const Icon(Icons.do_disturb_on_outlined),
                          iconSize: 30,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
