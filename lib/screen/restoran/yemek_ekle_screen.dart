import 'dart:io';

import 'package:askida_yemek/model/restorant_model.dart';
import 'package:askida_yemek/model/yemek_model.dart';
import 'package:askida_yemek/screen/home_screen.dart';
import 'package:askida_yemek/service/local_save/restorantlar_save.dart';
import 'package:askida_yemek/service/save_image/pick_manager.dart';
import 'package:askida_yemek/utils/constants/kullanici_items.dart';
import 'package:askida_yemek/utils/constants/padding_items.dart';
import 'package:askida_yemek/utils/constants/pick_image_items.dart';
import 'package:askida_yemek/utils/extensions/screen_size.dart';
import 'package:askida_yemek/utils/functions/print_islem.dart';
import 'package:askida_yemek/utils/widget/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class YemekEkleScreen extends StatefulWidget {
  const YemekEkleScreen({super.key, required this.restorantModel});
  final RestorantModel restorantModel;
  @override
  State<YemekEkleScreen> createState() => _YemekEkleScreenState();
}

class _YemekEkleScreenState extends State<YemekEkleScreen> {
  final TextEditingController _ad = TextEditingController();
  final TextEditingController _fiyat = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late RestorantModel restorantModel;

  late File file;
  final IPickManager pickManager = PickManger();
  XFile? image;
  PickImageItem itemImage = PickImageItem.gallery;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    restorantModel = widget.restorantModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yemek Kaydetme")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePicker(context),
            Form(
              key: _formKey,
              child: Padding(
                padding: PaddingItem.horizantalMedium.str(),
                child: Column(
                  children: [
                    Padding(
                      padding: PaddingItem.verticalMedium.str(),
                      child: TextFormField(
                        controller: _ad,
                        decoration:
                            customInputDecoration("Yemek adı", "Ad", context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Boş bırakmayın !";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: PaddingItem.verticalMedium.str(),
                      child: TextFormField(
                        controller: _fiyat,
                        decoration: customInputDecoration(
                            "Yemeğin fiyatı", "Fiyat", context),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Boş bırakmayın !";
                          }
                          String tamKisim = value.split(".").toList().first;
                          if (tamKisim.length > 8) {
                            return "Lütfen daha küçük bir sayı giriniz!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    printf("yemek kaydedildi");
                    PickManger().saveImage(image, "${_ad.text}-${_fiyat.text}");
                    //imageUrl = await PickManger().getImageUrl(${_ad.text}-${_fiyat.text});
                    YemekModel yemekModel = YemekModel(
                      id: 1,
                      yemekAd: _ad.text,
                      yemekFiyat: double.parse(_fiyat.text),
                      askidaYemek: 0,
                      yemekFotograf: imageUrl ?? "",
                    );
                    List<YemekModel> yemekList = restorantModel.yemekListe;
                    yemekList.add(yemekModel);
                    restorantModel.yemekListe = yemekList;
                    LocalSaveRestorant().update(restorantModel);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HomeScreen(secim: KullaniciItem.restorant),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: const Text("Yemeği Kaydet"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePicker(
    BuildContext context,
  ) {
    return Center(
      child: PopupMenuButton(
        tooltip: "Fotoğraf Yükleme",
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              value: PickImageItem.gallery,
              child: Text("Galeri"),
            ),
            const PopupMenuItem(
              value: PickImageItem.camera,
              child: Text("Kamera"),
            ),
          ];
        },
        onSelected: (value) async {
          // if value 1 show dialog
          if (value == PickImageItem.gallery) {
            itemImage = PickImageItem.gallery;
            // if value 2 show dialog
          } else if (value == PickImageItem.camera) {
            itemImage = PickImageItem.camera;
            await Permission.camera.request();
          }
          image = (await pickManager.fetchMediaImage(itemImage).onError(
            (error, stackTrace) {
              //print("eror");
              return null;
            },
          ));

          imageUrl = image?.path;
          setState(() {});
        },
        child: imageUrl == null
            ? _altarnativePhoto(context)
            : FutureBuilder(
                future: image?.readAsBytes(),
                builder:
                    (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                  try {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: PaddingItem.medium.str(),
                        child: SizedBox(
                          width: context.width / 1.5,
                          height: context.height / 3,
                          child: Image.file(
                            File(imageUrl ?? ""),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _altarnativePhoto(context);
                            },
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    //print("farklı resim seçin");
                    printf("hata : $e");
                    return _altarnativePhoto(context);
                  }
                },
              ),
      ),
    );
  }

  Widget _altarnativePhoto(BuildContext context) {
    return SizedBox(
        width: context.width / 4,
        child: Icon(
          Icons.add_photo_alternate_rounded,
          size: context.width / 4,
        ));
  }
}
