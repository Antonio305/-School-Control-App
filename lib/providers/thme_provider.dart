import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvier extends ChangeNotifier {
  // create getter setter
  // for change state

//  receribe two params  one ( is dark mode type bool) two
//  recerive theme
  ThemeData currentTheme;

  // create contructor
  ThemeProvier({required bool isDarkMode})
      : currentTheme = isDarkMode ? ThemeData.dark(  ) : ThemeData.light();

  // funtion set state theme

  setLightMode() {
    currentTheme = ThemeData.light();
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = ThemeData.dark();
    notifyListeners();
  }
}
