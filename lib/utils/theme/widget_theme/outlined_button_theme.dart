import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class outlinedButtonTheme {
  outlinedButtonTheme._(); // to avoid creating a instance

  // ligth elevated button theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: appBlackColor,
      side: BorderSide(color: appBlackColor),
      padding: EdgeInsets.symmetric(
        vertical: buttonHeight,
      ),
    ),
  );

  // dark elevated button theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: whiteColor,
      side: BorderSide(color: whiteColor),
      padding: EdgeInsets.symmetric(
        vertical: buttonHeight,
      ),
    ),
  );
}
