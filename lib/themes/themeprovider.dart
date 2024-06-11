import 'package:flutter/material.dart';
import 'package:my_first_app/themes/darkmode.dart';
import 'package:my_first_app/themes/lightmode.dart';

class Themeprovider with ChangeNotifier {
  // light mode by default
  ThemeData _themeData = lightmode;

  get themeDate => _themeData;

  // return true if its alrady the dark mode
  bool isDark() {
    return themeDate == darkmode;
  }

  // change the Theme
  void toggleTheme() {
    isDark() ? _themeData = lightmode : _themeData = darkmode;
    notifyListeners();
  }
}
