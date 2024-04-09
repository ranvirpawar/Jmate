import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jmate/utils/theme/widget_theme/text_field_theme.dart';
import 'package:jmate/utils/theme/widget_theme/text_theme.dart';
import 'package:jmate/utils/theme/widget_theme/outlined_button_theme.dart';
import 'package:jmate/utils/theme/widget_theme/elevated_button_theme.dart';

class AppTheme {
  AppTheme._(); // making it private so that it is not instantiable
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.montserratTextTheme(),
    outlinedButtonTheme: outlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: elevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    outlinedButtonTheme: outlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: elevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.darkInputDecorationTheme,
  );
}
