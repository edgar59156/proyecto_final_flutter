import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/provider/theme_provider.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
        
      },
    );
  }
}