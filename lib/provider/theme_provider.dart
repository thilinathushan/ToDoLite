import 'package:flutter/material.dart';
import '../Styles/dark_theme.dart';
import '../Styles/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lighttheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lighttheme) {
      themeData = darktheme;
    } else {
      themeData = lighttheme;
    }
  }
}
