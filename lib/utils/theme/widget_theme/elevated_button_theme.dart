import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class elevatedButtonTheme {
  elevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      foregroundColor: whiteColor,
      elevation: 1,
      backgroundColor: appBlackColor,
      side: BorderSide(
        color: appBlackColor,
      ),
      padding: EdgeInsets.symmetric(
        vertical: buttonHeight,
      ),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: appBlackColor,
      elevation: 0,
      backgroundColor: whiteColor,
      side: BorderSide(color: whiteColor),
      padding: EdgeInsets.symmetric(
        vertical: buttonHeight,
      ),
    ),
  );
}
