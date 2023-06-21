import 'dart:io';

import 'package:askida_yemek/model/restorant_model.dart';
import 'package:askida_yemek/model/sepet_model.dart';
import 'package:askida_yemek/service/local_save/kullanici_sepet_save.dart';
import 'package:askida_yemek/utils/constants/padding_items.dart';
import 'package:askida_yemek/utils/extensions/screen_size.dart';
import 'package:flutter/material.dart';

class RestorantDetayScreen extends StatefulWidget {
  const RestorantDetayScreen({super.key, required this.restorantModel});
  final RestorantModel restorantModel;
  @override
  State<RestorantDetayScreen> createState() => _RestorantDetayScreenState();
}

class _RestorantDetayScreenState extends State<RestorantDetayScreen> {
  late RestorantModel _restorantModel;
  @override
  void initState() {
    super.initState();
    _restorantModel = widget.restorantModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restorant Detay"),
      ),
      body: Column(
        children: [
          Padding(
            padding: PaddingItem.small.str(),
            child: Column(
              children: [
                SizedBox(
                  width: context.width,
                  child: Text(
                    "Restoran ad: ${_restorantModel.ad}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: context.width,
                  child: Text(
                    "Restoran il : ${_restorantModel.il}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: context.width,
                  child: Text(
                    "Restoran ilçe : ${_restorantModel.ilce}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: context.width,
                  child: Text(
                    "Restoran detaylı adres :${_restorantModel.adres}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: context.width,
                  child: Text(
                    "yemek çeşit sayısı : ${_restorantModel.yemekListe.length}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _restorantModel.yemekListe.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: PaddingItem.medium.str(),
                    child: Row(
                      children: [
                        Padding(
                          padding: PaddingItem.medium.str(),
                          child: Container(
                            child: _restorantModel
                                        .yemekListe[index].yemekFotograf ==
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
                                          _restorantModel
                                              .yemekListe[index].yemekFotograf,
                                        ),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return SizedBox(
                                            width: context.width / 6,
                                            height: context.width / 7,
                                            child: Icon(
                                              Icons.image,
                                              size: context.width / 7,
                                            ),
                                          );
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
                              width: context.width / 1.65,
                              child: Text(
                                "yemek ad: ${_restorantModel.yemekListe[index].yemekAd}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: context.width / 1.65,
                              child: Text(
                                "yemek fiyat:${_restorantModel.yemekListe[index].yemekFiyat}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: context.width / 1.65,
                              child: Text(
                                "askıdaki yemek sayısı:${_restorantModel.yemekListe[index].askidaYemek}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                LocalSaveSepet().insert(
                                  SepetModel(
                                    id: index,
                                    restorantModel: _restorantModel,
                                    yemekModel:
                                        _restorantModel.yemekListe[index],
                                  ),
                                );

                                //TODO bu kısımda ödeme yapmadan askıda yemeğe atıyor
                                //LocalSaveRestorant().update(newRestorantModel);
                                // setState(() {
                                //   _restorantModel = newRestorantModel;
                                // });
                              },
                              child: const Text("Askıya Yemek Bırak"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
