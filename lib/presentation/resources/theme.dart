import 'package:flutter/material.dart';

var appTheme = ThemeData(
  primaryColor: Colors.blueGrey.shade400,
  primaryColorLight: Colors.blueGrey.shade100,
  primaryColorDark: Colors.blueGrey.shade700,
  colorScheme: ColorScheme(
      primary: Colors.blueGrey.shade400,
      primaryVariant: Colors.blueGrey.shade700,
      secondary: Colors.amber.shade400,
      secondaryVariant: Colors.amber.shade100,
      surface: Colors.grey.shade50,
      background: Colors.white,
      error: Colors.pink.shade500,
      onPrimary: Colors.black87,
      onSecondary: Colors.black87,
      onSurface: Colors.black87,
      onBackground: Colors.blueGrey.shade900,
      onError: Colors.white10,
      brightness: Brightness.light),
  accentColor: Colors.deepOrange.shade600,
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.white),
    color: Colors.blueGrey.shade400,
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade300,
    thickness: 1.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
    ),
    bodyText2: TextStyle(
      fontSize: 16.0,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueGrey.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);
