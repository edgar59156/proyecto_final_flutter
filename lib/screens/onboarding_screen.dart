import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/theme_provider.dart';
import '../settings/style_settings.dart';
import '../shared_preferences/preferencias.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  bool statusB1 = true;
  bool statusB2 = false;
  bool statusB3 = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 3;
                });
              },
              children: [
                Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/bananaAppfondo.jpg'),
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.noRepeat,
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bienvenido to BananaApp',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/bananapprbg.png',
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Text(
                            'Ipsum nostrud veniam ullamco est cupidatat ullamco ut est. Quis id dolor ea quis culpa magna in anim est commodo nulla esse. Anim minim laborum exercitation dolore aliqua pariatur commodo et Lorem. Quis voluptate irure elit cupidatat Lorem laborum incididunt do velit id. Voluptate duis id est aliqua duis laboris incididunt occaecat amet anim aliquip do. Pariatur voluptate reprehenderit exercitation aute nisi enim non.',
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    )),
                
                
                Container(
                    //color: Theme.of(context).cardColor,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/bananaAppfondo.jpg'),
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.noRepeat,
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Agrega tareas',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/bananaTask.png',
                          fit: BoxFit.cover,
                          width: 250,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child:
                              const Text('Crea, modifica y elimina tus tareas'),
                        ),
                        const SizedBox(height: 40),
                      ],
                    )),
                Container(
                    //color: Theme.of(context).cardColor,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/bananaAppfondo.jpg'),
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.noRepeat,
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your BanAccount!',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/banaccount2.png',
                          fit: BoxFit.cover,
                          width: 210,
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/profileIcon.png',
                          fit: BoxFit.cover,
                          width: 120,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Text('Add your basic info'),
                        ),
                        const SizedBox(height: 40),
                      ],
                    )),
                Container(
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
                  ),
                ),
              ]),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                onPressed: () {
                  Preferences.showOnboardin = false;
                  Navigator.pushNamed(context, '/login');
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(double.infinity, 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                ),
                child: const Text('Get Satarted'),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Theme.of(context).primaryColor,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text(
                        'SKIP',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.jumpToPage(3);
                      },
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        effect: const ColorTransitionEffect(
                            spacing: 16,
                            dotColor: Colors.black26,
                            activeDotColor: Colors.white),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                      child: const Text('NEXT',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                    ),
                  ],
                ),
              ));
  }
}

class _Sider extends StatelessWidget {
  const _Sider({
    Key? key,
    required this.titel,
    required this.content,
    this.image,
    required this.color,
    this.buttons,
  }) : super(key: key);
  final String titel;
  final String content;
  final String? image;
  final Color? color;
  final Widget? buttons;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titel),
          ],
        ));
  }
}
