import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IshortProvider with ChangeNotifier{
  bool _isShort = false;
  bool get isShort => _isShort;

  IshortProvider(){
    _loadFromPrefs();
  }
  void toggleIsShort(bool isOn) async {
    _isShort = isOn;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsShort', _isShort);
  }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isShort = prefs.getBool('IsShort') ?? false;
    notifyListeners();
  }
}