import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../settings/style_settings.dart';
import '../shared_preferences/preferencias.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool statusB1 = true;
  bool statusB2 = false;
  bool statusB3 = false;

  @override
  Widget build(BuildContext context) {
    if (Preferences.themeUsed == 0) {
      statusB1 = true;
      statusB2 = false;
      statusB3 = false;
    } else if (Preferences.themeUsed == 1) {
      statusB1 = false;
      statusB2 = true;
      statusB3 = false;
    } else if (Preferences.themeUsed == 2) {
      statusB1 = false;
      statusB2 = false;
      statusB3 = true;
    }
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Select Theme'),
        ),
        body: Container(

            //color: Theme.of(context).cardColor,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/themeColor.jpg'),
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select theme',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                Image.asset(
                  'assets/themeIcon.png',
                  fit: BoxFit.cover,
                  width: 150,
                  color: Colors.white,
                ),
                const SizedBox(height: 14),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Tema de dia',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FlutterSwitch(
                      activeColor: Colors.green,
                      width: 125.0,
                      height: 55.0,
                      valueFontSize: 25.0,
                      toggleSize: 45.0,
                      value: statusB1,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      activeIcon: Icon(
                        Icons.wb_sunny,
                        color: Colors.yellow,
                      ),
                      inactiveIcon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onToggle: (val) {
                        setState(() {
                          statusB1 = val;
                          statusB2 = false;
                          statusB3 = false;
                          if (statusB1 == true) {
                            Preferences.themeUsed = 0;
                            tema.setthemeData(temaDia());
                          }
                          print(Preferences.themeUsed);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Tema calido',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    FlutterSwitch(
                      activeColor: Colors.green,
                      width: 125.0,
                      height: 55.0,
                      valueFontSize: 25.0,
                      toggleSize: 45.0,
                      value: statusB2,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      activeIcon: Icon(
                        Icons.wb_sunny_outlined,
                        color: Colors.yellow,
                      ),
                      inactiveIcon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onToggle: (val) {
                        setState(() {
                          statusB1 = false;
                          statusB2 = val;
                          statusB3 = false;
                          if (statusB2 == true) {
                            Preferences.themeUsed = 1;
                            tema.setthemeData(temaCalido());
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Tema de noche',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    FlutterSwitch(
                      activeColor: Colors.green,
                      width: 125.0,
                      height: 55.0,
                      valueFontSize: 25.0,
                      toggleSize: 45.0,
                      value: statusB3,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      activeIcon: Icon(
                        Icons.nightlight_round,
                        color: Colors.black,
                      ),
                      inactiveIcon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onToggle: (val) {
                        setState(() {
                          statusB1 = false;
                          statusB2 = false;
                          statusB3 = val;
                          if (statusB3 == true) {
                            Preferences.themeUsed = 2;
                            tema.setthemeData(temaNoche());
                          }
                        });
                      },
                    ),

                    /* TextButton.icon(
                      onPressed: () {
                        print('dia');
                        tema.setthemeData(temaDia());
                      },
                      icon: Icon(Icons.brightness_1),
                      label: Text('Tema de Día'),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        print('noche');
                        tema.setthemeData(temaNoche());
                      },
                      icon: Icon(Icons.dark_mode),
                      label: Text('Tema de Noche'),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        print('calido');
                        tema.setthemeData(temaCalido());
                      },
                      icon: Icon(Icons.hot_tub_sharp),
                      label: Text('Tema de Día'),
                    ),*/
                  ],
                ),
                const SizedBox(height: 40),
                /*Image.asset(
                  'assets/bananapp.jpg',
                  fit: BoxFit.cover,
                  width: 60,
                ),
                */

                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Texto de ejemplo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 20,
                      right: MediaQuery.of(context).size.width / 20,
                      bottom: MediaQuery.of(context).size.width / 20,
                    ),
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
              ],
            )));
  }
}
