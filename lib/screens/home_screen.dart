import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/arguments_model.dart';
import 'package:proyecto_final/screens/courses_screen.dart';
import 'package:proyecto_final/screens/message_screen.dart';
import 'package:proyecto_final/screens/my_courses_screen.dart';
import 'package:proyecto_final/screens/notifications_screen.dart';
import 'package:proyecto_final/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  final screens = [CoursesScreen(), MyCoursesScreen(), ProfilePage()];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
            ),
            IconButton(
              icon: Icon(
                Icons.rss_feed,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseMessaging.instance.subscribeToTopic('Cursos').then(
                  (value) {
                    final snackBar = SnackBar(
                        content: Text('Te has suscrito al tema',
                            style: TextStyle(
                                fontFamily: 'Mukta',
                                fontWeight: FontWeight.bold)));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
            )
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.list, size: 30),
            Icon(Icons.add_to_photos, size: 30),
            Icon(Icons.account_box_outlined, size: 30),
          ],
          color: Colors.lightBlue,
          buttonBackgroundColor: Colors.grey.shade500,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: IndexedStack(
          index: _page,
          children: screens,
        ));
  }
}
