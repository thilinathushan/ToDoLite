import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Styles/styles.dart';
import '../Styles/light_theme.dart';
import '../provider/theme_provider.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  Color selectTextColor(ThemeData themeData) {
    Color textColor;
    if (themeData == lighttheme) {
      textColor = darkprimary;
    } else {
      textColor = primaryWhite;
    }
    return textColor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.tertiary,
      textColor: selectTextColor(Provider.of<ThemeProvider>(context).themeData),
      child: Text(text),
    );
  }
}
