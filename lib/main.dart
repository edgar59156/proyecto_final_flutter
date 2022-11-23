import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/provider/login_provider.dart';
import 'package:proyecto_final/provider/theme_provider.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/screens/login_screen.dart';
import 'package:proyecto_final/screens/onboarding_screen.dart';
import 'package:proyecto_final/screens/profile_screen.dart';
import 'package:proyecto_final/screens/profile_screen_social.dart';
import 'package:proyecto_final/screens/profile_screens/edit_image.dart';
import 'package:proyecto_final/screens/select_theme.dart';
import 'package:proyecto_final/screens/sign_up_screen.dart';
import 'package:proyecto_final/screens/splash_screen.dart';
import 'package:proyecto_final/shared_preferences/preferencias.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
          child: LoginScreen(),
        )
        //ChangeNotifierProvider(create: (_) => AppNotifier())
        /*ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        ),*/
      ],
      child: PFinalApp(),
    );
  }
}

class PFinalApp extends StatelessWidget {
  const PFinalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cento Comunitario',
      home: const SplashScreen(),
      routes: {
        '/home': (BuildContext context) => HomeScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/profileS': (BuildContext context) => ProfilePageSocial(),
        '/editImage': (BuildContext context) => EditImagePage(),
        '/theme': (BuildContext context) => SelectScreen(),
        '/onboarding': (BuildContext context) => OnboardingScreen(),
        '/signup': (BuildContext context) => SignUpScreen(),
      },
    );
  }
}
