import 'package:flutter/material.dart';

import '../../../auth/constants/colors.dart';
import '../../../auth/constants/sizes.dart';

class outlinedButtonTheme {
  outlinedButtonTheme._(); // to avoid creating a instance

  // ligth elevated button theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      foregroundColor: secondaryColor,
      side: BorderSide(color: secondaryColor),
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
