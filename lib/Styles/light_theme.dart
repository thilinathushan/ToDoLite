import 'package:flutter/material.dart';
import 'styles.dart';

ThemeData lighttheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: primaryWhite,
    primary: dialogBoxBg,
    secondary: greyColor,
    tertiary: tertiaryColor,
  ),
);
