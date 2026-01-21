import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _key = 'isDark';
  bool isDark = false;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> toggle(bool value) async {
    isDark = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark);
  }

  ThemeMode get mode => isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {}
}
