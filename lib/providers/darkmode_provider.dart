import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class DarkmodeProvider with ChangeNotifier{
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleDM(bool isOn){
    _isDarkMode = isOn;
    notifyListeners();
  }
}