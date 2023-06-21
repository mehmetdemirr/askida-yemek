enum LottieItem { theme, medicine, medicineSplash }

const String a = "assets/lottie";

extension LottieItems on LottieItem {
  String str() {
    switch (this) {
      case LottieItem.theme:
        return "$a/dark_mode.json";
      case LottieItem.medicine:
        return "$a/medicine.json";
      case LottieItem.medicineSplash:
        return "$a/medicine-splash.json";
    }
  }
}
