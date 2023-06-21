import 'package:askida_yemek/cache/shared_pref.dart';
import 'package:askida_yemek/model/kullanici_model.dart';
import 'package:askida_yemek/screen/home_screen.dart';
import 'package:askida_yemek/screen/kullanici/kullanici_kayitol_screen.dart';
import 'package:askida_yemek/service/local_save/kullanicilar_save.dart';
import 'package:askida_yemek/utils/constants/kullanici_items.dart';
import 'package:askida_yemek/utils/constants/padding_items.dart';
import 'package:askida_yemek/utils/extensions/email_validate.dart';
import 'package:askida_yemek/utils/extensions/screen_size.dart';
import 'package:askida_yemek/utils/functions/print_islem.dart';
import 'package:askida_yemek/utils/widget/custom_input_decoration.dart';
import 'package:flutter/material.dart';

class KullaniciGiris extends StatefulWidget {
  const KullaniciGiris({super.key});
  @override
  State<KullaniciGiris> createState() => _KullaniciGirisState();
}

class _KullaniciGirisState extends State<KullaniciGiris> {
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _parola = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kullancı ile Giriş")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: PaddingItem.horizantalMedium.str(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: PaddingItem.small.str(),
                      child: Image.asset("assets/images/askida_yemek.png"),
                    ),
                    Padding(
                      padding: PaddingItem.verticalMedium.str(),
                      child: TextFormField(
                        controller: _mail,
                        decoration: customInputDecoration(
                            "E-mail adresi", "E-Mail", context),
                        validator: (value) {
                          bool deger = value!.emailValidation();
                          if (value.isEmpty) {
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
                        controller: _parola,
                        decoration: customInputDecoration(
                            "Parola giriniz", "Parola", context),
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
                    List<KullaniciModel> list = LocalSaveKullanici().read();
                    for (var model in list) {
                      if (model.mail == _mail.text &&
                          model.parola == _parola.text) {
                        await SharedPref.setLogin(true);
                        await SharedPref.setKullaniciCesit(2);
                        await SharedPref.setData(
                            "${_mail.text},${_parola.text}");
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(
                                secim: KullaniciItem.kullanici),
                          ),
                          (Route<dynamic> route) => false,
                        );
                        break;
                      }
                    }
                    // TODO mail veya parola hatalı
                    printf("Giriş yapılamadı mail veya parola hatalı");
                  }
                },
                child: const Text("Giriş Yap"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const KullaniciKayitol()));
              },
              child: Text(
                "Kullanıcı hesabın yok mu ? Kayıt Ol",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
