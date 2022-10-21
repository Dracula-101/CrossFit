import 'package:crossfit/styles/colors.dart';
import 'package:flutter/material.dart';

// dark theme
ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: darkGrey,
  ),
  backgroundColor: darkGrey,
  scaffoldBackgroundColor: darkGrey,
  colorScheme: ColorScheme.dark(
    primary: darkGrey,
    secondary: darkGreyContrast,
    onPrimary: white,
    onSecondary: white,
    onSurface: white,
    onBackground: white,
    onError: white,
    surface: darkGrey,
    background: darkGrey,
    error: lightRed,
  ),
  fontFamily: 'Nunito',
  useMaterial3: true,
);
