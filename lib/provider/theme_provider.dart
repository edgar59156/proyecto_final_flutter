import 'package:flutter/material.dart';

import '../settings/style_settings.dart';


class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData; // = temaDia();

  getthemeData() //=> _themeData;
  {
        return _themeData = temaDia(); 
  }

  setthemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
