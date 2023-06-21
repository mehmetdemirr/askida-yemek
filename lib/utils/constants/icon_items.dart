enum IconItem {
  deger,
}

extension IconItems on IconItem {
  String str() {
    switch (this) {
      case IconItem.deger:
        return "deger";
    }
  }
}
