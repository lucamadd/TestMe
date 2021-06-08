import 'package:flutter/material.dart';
import 'package:test_me/storage_manager.dart';

import 'helpers/utils.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
      fontFamily: 'Manrope',
      primarySwatch: Colors.grey,
      primaryColor: createMaterialColor(Color(0xff5e65f3)),
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF1D1D1D),
      accentColor: const Color(0xFFB4B4B4),
      accentIconTheme: IconThemeData(color: Color(0xFFB4B4B4)),
      dividerColor: Colors.grey.shade800,
      iconTheme: IconThemeData(color: Color(0xFFB4B4B4)),
      bottomAppBarColor: const Color(0xFF2D2D2D));

  final lightTheme = ThemeData(
    fontFamily: 'Manrope',
    primarySwatch: createMaterialColor(Color(0xff5e65f3)),
    primaryColor: createMaterialColor(Color(0xff5e65f3)),
    backgroundColor: const Color(0xFFFFFFFF),
    brightness: Brightness.light,
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Color(0xFFB4B4B4)),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  bool isDarkTheme() {
    return _themeData == darkTheme;
  }

  bool isLightTheme() {
    return _themeData == lightTheme;
  }
}
