import 'package:flutter/material.dart';
import 'styles.dart';

ThemeData darktheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: darkprimary,
    primary: darkDialogBoxBg,
    secondary: greyColor,
    tertiary: tertiaryColor,
  ),
);
