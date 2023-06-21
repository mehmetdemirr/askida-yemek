import 'package:flutter/material.dart';

enum BorderItem {
  small,
  medium,
  large,
}

extension BorderItems on BorderItem {
  BorderRadius str() {
    switch (this) {
      case BorderItem.small:
        return const BorderRadius.all(Radius.circular(10));
      case BorderItem.medium:
        return const BorderRadius.all(Radius.circular(15));
      case BorderItem.large:
        return const BorderRadius.all(Radius.circular(25));
    }
  }
}
