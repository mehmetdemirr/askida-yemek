import 'package:askida_yemek/utils/constants/border_items.dart';
import 'package:flutter/material.dart';

InputDecoration customInputDecoration(
    String hintText, String labelText, BuildContext context) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: Theme.of(context).textTheme.bodyMedium,
    labelText: labelText,
    labelStyle: Theme.of(context).textTheme.bodyMedium,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 3, color: Colors.black26),
      borderRadius: BorderItem.small.str(),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 3, color: Colors.black12),
      borderRadius: BorderItem.small.str(),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 3, color: Colors.red.shade400),
      borderRadius: BorderItem.small.str(),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 3, color: Colors.brown),
      borderRadius: BorderItem.small.str(),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 3, color: Colors.red.shade700),
      borderRadius: BorderItem.small.str(),
    ),
  );
}
