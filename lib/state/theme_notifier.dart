import 'package:flutter/material.dart';
import 'package:pet_adoption/common/theme/app_theme.dart';

class ThemeNotifier with ChangeNotifier {
  static final ThemeNotifier _instance = ThemeNotifier._internal();

  factory ThemeNotifier() {
    return _instance;
  }

  ThemeData _themeData = lightTheme;

  ThemeNotifier._internal();

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData =
        _themeData.brightness == Brightness.light ? darkTheme : lightTheme;
    notifyListeners();
  }
}
