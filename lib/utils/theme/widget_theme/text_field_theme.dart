import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

import '../../../constants/colors.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._(); // making it private so that it is not instantiable
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    fillColor: Colors.grey[100],
    filled: true,
    hintStyle: TextStyle(color: Colors.grey),
    floatingLabelStyle: TextStyle(color: appBlackColor),
  );

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: whiteColor,
    floatingLabelStyle: TextStyle(color: appBlackColor),
    focusedBorder: OutlineInputBorder(),
  );
}
