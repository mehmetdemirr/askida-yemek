import 'package:flutter/material.dart';

enum PaddingItem {
  small,
  medium,
  large,
  horizantalSmall,
  horizantalMedium,
  horizantalLarge,
  verticalSmall,
  verticalMedium,
  verticallLarge,
  topSmall,
  topMedium,
  topLarge,
  bottomSmall,
  bottomMedium,
  bottomlLarge,
  leftSmall,
  leftMedium,
  leftLarge,
  rightmSmall,
  rightmMedium,
  rightlLarge,
}

extension PaddingItems on PaddingItem {
  EdgeInsets str() {
    switch (this) {
      case PaddingItem.small:
        return const EdgeInsets.all(10);
      case PaddingItem.medium:
        return const EdgeInsets.all(15);
      case PaddingItem.large:
        return const EdgeInsets.all(25);
      case PaddingItem.horizantalSmall:
        return const EdgeInsets.symmetric(horizontal: 10);
      case PaddingItem.horizantalMedium:
        return const EdgeInsets.symmetric(horizontal: 15);
      case PaddingItem.horizantalLarge:
        return const EdgeInsets.symmetric(horizontal: 25);
      case PaddingItem.verticalSmall:
        return const EdgeInsets.symmetric(vertical: 10);
      case PaddingItem.verticalMedium:
        return const EdgeInsets.symmetric(vertical: 15);
      case PaddingItem.verticallLarge:
        return const EdgeInsets.symmetric(vertical: 25);
      case PaddingItem.topSmall:
        return const EdgeInsets.only(top: 10);
      case PaddingItem.topMedium:
        return const EdgeInsets.only(top: 15);
      case PaddingItem.topLarge:
        return const EdgeInsets.only(top: 25);
      case PaddingItem.bottomSmall:
        return const EdgeInsets.only(bottom: 10);
      case PaddingItem.bottomMedium:
        return const EdgeInsets.only(bottom: 15);
      case PaddingItem.bottomlLarge:
        return const EdgeInsets.only(bottom: 25);
      case PaddingItem.leftSmall:
        return const EdgeInsets.only(left: 10);
      case PaddingItem.leftMedium:
        return const EdgeInsets.only(left: 15);
      case PaddingItem.leftLarge:
        return const EdgeInsets.only(left: 25);
      case PaddingItem.rightmSmall:
        return const EdgeInsets.only(right: 10);
      case PaddingItem.rightmMedium:
        return const EdgeInsets.only(right: 15);
      case PaddingItem.rightlLarge:
        return const EdgeInsets.only(right: 25);
    }
  }
}
