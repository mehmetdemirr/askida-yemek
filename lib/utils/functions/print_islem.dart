import 'package:flutter/foundation.dart';

void printf(String text) {
  if (kDebugMode) {
    print(text);
  }
}
