enum JsonItem {
  ilaclar,
}

extension JsonItems on JsonItem {
  static String a = "assets/json";
  String str() {
    switch (this) {
      case JsonItem.ilaclar:
        return "$a/ilaclar.json";
    }
  }
}
