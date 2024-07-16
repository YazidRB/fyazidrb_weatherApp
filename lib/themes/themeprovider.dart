import 'package:flutter/material.dart';
import 'package:fyazidrb_weatherapp/themes/darkmode.dart';
import 'package:fyazidrb_weatherapp/themes/lightmode.dart';

class Themeprovider with ChangeNotifier {
  // light mode by default
  ThemeData _themeData = lightmode;

  get themeDate => _themeData;

  // return true if dark mode enabled , false otherwise
  bool isDark() {
    return themeDate == darkmode;
  }

  // change the current Theme
  void toggleTheme() {
    isDark() ? _themeData = lightmode : _themeData = darkmode;
    notifyListeners();
  }
}
