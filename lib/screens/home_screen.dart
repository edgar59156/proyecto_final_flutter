import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/courses_screen.dart';
import 'package:proyecto_final/screens/my_courses_screen.dart';
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
          backgroundColor: Colors.white,
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
