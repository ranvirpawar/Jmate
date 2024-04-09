import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class elevatedButtonTheme {
  elevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: whiteColor,
      elevation: 0,
      backgroundColor: secondaryColor,
      side: BorderSide(
        color: secondaryColor,
      ),
      padding: EdgeInsets.symmetric(
        vertical: buttonHeight,
      ),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: secondaryColor,
      elevation: 0,
      backgroundColor: whiteColor,
      side: BorderSide(color: whiteColor),
      padding: EdgeInsets.symmetric(
        vertical: buttonHeight,
      ),
    ),
  );
}
