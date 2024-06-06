import 'package:flutter/material.dart';

class AppIconTheme {
  AppIconTheme._();
  static const Color iconColor = Color.fromRGBO(194, 52, 1, 1);
  static const  lightIconTheme =  IconThemeData(
    color:  iconColor,
    size:  24.0,
  );
  static const  darkIconTheme = IconThemeData(
    color: Color.fromRGBO(194, 52, 0, 1),
    size: 24.0,
  );
}
