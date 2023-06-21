import 'dart:io';

import 'package:askida_yemek/model/sepet_model.dart';
import 'package:askida_yemek/screen/kullanici/odeme_screen.dart';
import 'package:askida_yemek/service/local_save/kullanici_sepet_save.dart';
import 'package:askida_yemek/utils/extensions/screen_size.dart';
import 'package:askida_yemek/utils/functions/print_islem.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/padding_items.dart';

class SepetScreen extends StatefulWidget {
  const SepetScreen({super.key});
  @override
  State<SepetScreen> createState() => _SepetScreenState();
}

class _SepetScreenState extends State<SepetScreen> {
  late List<SepetModel> sepetListesi;
  double toplamTutar = 0;
  @override
  void initState() {
    super.initState();
    getYemekList();
    for (var i in sepetListesi) {
      toplamTutar += i.yemekModel.yemekFiyat;
    }
  }

  Future<void> getYemekList() async {
    sepetListesi = LocalSaveSepet().read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sepet")),
      body: sepetListesi.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sepette yemek bulunmadı !"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: sepetListesi.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: PaddingItem.medium.str(),
                    child: Row(
                      children: [
                        Padding(
                          padding: PaddingItem.medium.str(),
                          child: Container(
                            child:
                                sepetListesi[index].yemekModel.yemekFotograf ==
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
                                              sepetListesi[index]
                                                  .yemekModel
                                                  .yemekFotograf,
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
                          children: [
                            SizedBox(
                              width: context.width / 1.95,
                              child: Text(
                                "yemek adı : ${sepetListesi[index].yemekModel.yemekAd}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: context.width / 1.95,
                              child: Text(
                                "yemek fiyat : ${sepetListesi[index].yemekModel.yemekFiyat}",
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
                            LocalSaveSepet().delete(index);
                            getYemekList().then((value) {
                              toplamTutar = 0;
                              for (var i in sepetListesi) {
                                toplamTutar += i.yemekModel.yemekFiyat;
                              }
                              setState(() {});
                            });
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding:
            PaddingItem.horizantalMedium.str() + PaddingItem.bottomMedium.str(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: context.width,
              child: Text(
                "Ödeme Tutarı :$toplamTutar TL ",
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: PaddingItem.topSmall.str(),
              child: SizedBox(
                width: context.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (sepetListesi.isNotEmpty && toplamTutar != 0) {
                      printf("yemek kaydedildi");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OdemeScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text("Ödeme Yap"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
