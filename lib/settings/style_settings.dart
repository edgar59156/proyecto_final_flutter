import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData temaDia() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Colors.red,
  );
}

ThemeData temaNoche() {
  final ThemeData base = ThemeData.dark();
  /*return base.copyWith(
    primaryColor: Color.fromARGB(255, 75, 17, 5),
    textTheme: TextTheme(
      caption: TextStyle(color: Colors.purple),
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: Colors.orange,
      displayColor: Colors.yellow,
      decorationColor: Colors.yellow,
    ),
    iconTheme: IconThemeData(color: Colors.amber),
    primaryTextTheme: const TextTheme(
      caption: TextStyle(
        color: Color.fromARGB(179, 255, 0, 0),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
  );*/
  return base.copyWith(
      primaryColor: Color.fromARGB(255, 114, 84, 43),
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
          bodyColor: Colors.orange,
          displayColor: Colors.yellow,
          decorationColor: Colors.yellow),
      hintColor: Colors.blue,
      unselectedWidgetColor: Colors.blue);
}

ThemeData temaCalido() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
      primaryColor: Color.fromARGB(255, 231, 146, 26),
      textTheme: GoogleFonts.getTextTheme(
              "Comic Neue",
              TextTheme(
                bodyText1: TextStyle(),
                bodyText2: TextStyle(),
                headline1: TextStyle(
                  color: Colors.blue,
                ),
                headline2: TextStyle(
                  color: Colors.blue,
                ),
                headline3: TextStyle(
                  color: Colors.blue,
                ),
                headline4: TextStyle(
                  color: Colors.blue,
                ),
                headline5: TextStyle(
                  color: Colors.blue,
                ),
                headline6: TextStyle(
                  color: Colors.blue,
                ),
                overline: TextStyle(
                  color: Colors.blue,
                ),
                subtitle1: TextStyle(
                  color: Colors.blue,
                ),
                subtitle2: TextStyle(
                  color: Colors.blue,
                ),
                button: TextStyle(
                  color: Colors.blue,
                ),
                caption: TextStyle(
                  color: Colors.blue,
                ),
              ))
          .apply(
              bodyColor: Colors.red,
              displayColor: Colors.red,
              decorationColor: Colors.red),
      hintColor: Colors.blue,
      unselectedWidgetColor: Colors.blue);
}
