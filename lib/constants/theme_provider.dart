import 'package:flutter/material.dart';
import 'package:notes_app/constants/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ligthMode;

  ThemeData get themeData => _themeData;

  bool get isDark => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == ligthMode) {
      themeData = darkMode;
    } else {
      themeData = ligthMode;
    }
  }
}
