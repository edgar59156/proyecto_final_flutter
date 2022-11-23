import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../settings/style_settings.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextButton.icon(
              onPressed: () {
                tema.setthemeData(temaDia());
              },
              icon: Icon(Icons.brightness_1),
              label: Text('Tema de dia')),
          TextButton.icon(
              onPressed: () {
                tema.setthemeData(temaNoche());
              },
              icon: Icon(Icons.dark_mode),
              label: Text('Tema de noche')),
          TextButton.icon(
              onPressed: () {
                tema.setthemeData(temaCalido());
              },
              icon: Icon(Icons.hot_tub),
              label: Text('Tema de calido'))
        ],
      )),
    );
  }
}
