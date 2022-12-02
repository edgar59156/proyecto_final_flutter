import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _name = '';
  static bool _isLogged = false;
  static String _email = '';
  static String _lastName = '';
  static bool _showOnboradin = true;
  static int _themeUsed = 0;
  static bool _susbVal = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name(String name) {
    _name = name;
    _prefs.setString('name', name);
  }

  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email(String email) {
    _email = email;
    _prefs.setString('email', email);
  }

  static String get lastName {
    return _prefs.getString('lastName') ?? _lastName;
  }

  static set lastName(String lastName) {
    _lastName = lastName;
    _prefs.setString('lastName', lastName);
  }

  static bool get isLogged {
    return _prefs.getBool('isLogged') ?? _isLogged;
  }

  static set isLogged(bool value) {
    _isLogged = value;
    _prefs.setBool('isLogged', value);
  }

  static int get themeUsed {
    return _prefs.getInt('themeUsed') ?? _themeUsed;
  }

  static set themeUsed(int value) {
    _themeUsed = value;
    _prefs.setInt('themeUsed', value);
  }

  static set showOnboardin(bool show) {
    _showOnboradin = show;
    _prefs.setBool('showOnboarding', _showOnboradin);
  }

  static bool get showOnboardin {
    return _prefs.getBool('showOnboarding') ?? _showOnboradin;
  }
   static set susbVal(bool show) {
    _susbVal = show;
    _prefs.setBool('susbValg', _susbVal);
  }

  static bool get susbVal {
    return _prefs.getBool('susbValg') ?? _susbVal;
  }
}
