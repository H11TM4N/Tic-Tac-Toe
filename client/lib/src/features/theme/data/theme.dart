import 'package:tic_tac_toe/src/shared/shared.dart';
import 'package:flutter/material.dart';

final baseTheme = ThemeData.light();

ThemeData appTheme = ThemeData(
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: 18,
    ),
  ).apply(
    fontFamily: outfit,
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: appColors.lightBlue,
    onPrimary: appColors.darkNavy,
    surface: appColors.darkNavy,
  ),
);

var appColors = AppColors();
