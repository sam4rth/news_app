import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkmodeProvider with ChangeNotifier{
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  DarkmodeProvider(){
    _loadFromPrefs();
  }
  void toggleDM(bool isOn) async {
    _isDarkMode = isOn;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkmode', _isDarkMode);
  }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkmode') ?? false;
    notifyListeners();
  }
}