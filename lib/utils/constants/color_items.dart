import 'package:flutter/material.dart';

enum ColorItem {
  scaffold,
  koyuRenk,
  acikRenk,
  birZitRenk,
  birAraRenk,
  ikiAraRenk,
  araRenkAcik
}

extension ColorItems on ColorItem {
  Color str() {
    switch (this) {
      case ColorItem.scaffold:
        return Colors.grey.shade300; //const Color(0xFFF3F3F3);
      case ColorItem.koyuRenk:
        return const Color(0xFF1B4965);
      case ColorItem.acikRenk:
        return const Color(0xFFCAE9FF);
      case ColorItem.birZitRenk:
        return const Color(0xFFBEE9E8);
      case ColorItem.birAraRenk:
        return const Color(0xFF72AFD2);
      case ColorItem.ikiAraRenk:
        return const Color(0xFF74C5DA);
      case ColorItem.araRenkAcik:
        return const Color(0xFF5C8EAC);
    }
  }
}
