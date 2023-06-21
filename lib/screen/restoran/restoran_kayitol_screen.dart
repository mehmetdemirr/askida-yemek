import 'package:askida_yemek/cache/shared_pref.dart';
import 'package:askida_yemek/model/restorant_model.dart';
import 'package:askida_yemek/screen/home_screen.dart';
import 'package:askida_yemek/screen/restoran/restoran_giris_screen.dart';
import 'package:askida_yemek/service/local_save/restorantlar_save.dart';
import 'package:askida_yemek/utils/constants/kullanici_items.dart';
import 'package:askida_yemek/utils/constants/padding_items.dart';
import 'package:askida_yemek/utils/extensions/email_validate.dart';
import 'package:askida_yemek/utils/extensions/screen_size.dart';
import 'package:askida_yemek/utils/functions/print_islem.dart';
import 'package:askida_yemek/utils/widget/custom_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RestoranKayitol extends StatefulWidget {
  const RestoranKayitol({super.key});
  @override
  State<RestoranKayitol> createState() => _RestoranKayitolState();
}

class _RestoranKayitolState extends State<RestoranKayitol> {
  final TextEditingController _ad = TextEditingController();
  final TextEditingController _il = TextEditingController();
  final TextEditingController _ilce = TextEditingController();
  final TextEditingController _numara = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _adres = TextEditingController();
  final TextEditingController _parola = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(
    mask: '0 (5##) ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restoran ile Kayıt Ol")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: PaddingItem.horizantalMedium.str(),
                child: Column(
                  children: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.image),
                    //   iconSize: 100,
                    // ),
                    Padding(
                      padding: PaddingItem.verticalMedium.str() +
                          PaddingItem.topLarge.str() * 1.5,
                      child: TextFormField(
                        controller: _ad,
                        decoration: customInputDecoration(
                            "Restorant adı", "Ad", context),
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
                        controller: _il,
                        decoration: customInputDecoration(
                            "Restorantın bulunduğu il", "İl", context),
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
                        controller: _ilce,
                        decoration: customInputDecoration(
                            "Restorantın bulunduğu ilçe", "İlçe", context),
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
                        controller: _numara,
                        inputFormatters: [maskFormatter],
                        keyboardType: TextInputType.number,
                        decoration: customInputDecoration(
                            "Telefon numarası", "Telefon", context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Boş bırakmayın !";
                          }
                          if (value.length != 17) {
                            return "Geçerli bir numara giriniz !";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: PaddingItem.verticalMedium.str(),
                      child: TextFormField(
                        controller: _mail,
                        decoration: customInputDecoration(
                            "E-mail adresi", "E-Mail", context),
                        validator: (value) {
                          bool deger = value.emailValidation();
                          if (value!.isEmpty) {
                            return "Boş bırakmayın !";
                          }
                          if (!deger) {
                            return "Geçerli bir e-mail giriniz !";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: PaddingItem.verticalMedium.str(),
                      child: TextFormField(
                        controller: _adres,
                        maxLines: 2,
                        decoration: customInputDecoration(
                            "Restorantın açık adresi", "Adres", context),
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
                        controller: _parola,
                        decoration: customInputDecoration(
                            "Parolanızı oluşturun", "Parola", context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Boş bırakmayın !";
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
                    printf("kayıt olundu");
                    RestorantModel restorant = RestorantModel(
                      id: _mail.text,
                      ad: _ad.text,
                      il: _il.text,
                      ilce: _ilce.text,
                      telefon: _numara.text,
                      mail: _mail.text,
                      adres: _adres.text,
                      parola: _parola.text,
                      fotograf: '',
                      yemekListe: [],
                    );
                    LocalSaveRestorant().insert(restorant);
                    await SharedPref.setLogin(true);
                    await SharedPref.setKullaniciCesit(1);
                    await SharedPref.setData("${_mail.text},${_parola.text}");
                    // ignore: use_build_context_synchronously
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
                child: const Text("Kayıt ol"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RestoranGiris()));
              },
              child: Text(
                "Restoran hesabın var mı ? Giriş Yap",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
