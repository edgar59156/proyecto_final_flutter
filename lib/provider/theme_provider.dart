import 'package:flutter/material.dart';

import '../settings/style_settings.dart';
import '../shared_preferences/preferencias.dart';


class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData; // = temaDia();

 getthemeData() //=> _themeData;
  {
    print(Preferences.themeUsed);

    if (Preferences.themeUsed == 0) {
      return _themeData = temaDia();
    } else if (Preferences.themeUsed == 1) {
      return _themeData = temaCalido();
    } else if (Preferences.themeUsed == 2) {
      return _themeData = temaNoche();
    }
  }

  setthemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
