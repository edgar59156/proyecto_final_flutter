import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/firebase/notifications_firebase.dart';
import 'package:proyecto_final/models/notifications_model.dart';
import 'package:proyecto_final/provider/login_provider.dart';
import 'package:proyecto_final/provider/theme_provider.dart';
import 'package:proyecto_final/screens/home_screen.dart';
import 'package:proyecto_final/screens/home_screen_social.dart';
import 'package:proyecto_final/screens/login_screen.dart';
import 'package:proyecto_final/screens/message_screen_user.dart';
import 'package:proyecto_final/screens/notifications_screen.dart';
import 'package:proyecto_final/screens/onboarding_screen.dart';
import 'package:proyecto_final/screens/profile_screen.dart';
import 'package:proyecto_final/screens/profile_screen_social.dart';
import 'package:proyecto_final/screens/profile_screens/edit_image.dart';
import 'package:proyecto_final/screens/sign_up_screen.dart';
import 'package:proyecto_final/screens/splash_screen.dart';
import 'package:proyecto_final/screens/theme_screen.dart';
import 'package:proyecto_final/services/push_notifications_services.dart';
import 'package:proyecto_final/shared_preferences/preferencias.dart';

import 'screens/message_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preferences.init();
  await PushNotificationService.initializeApp();
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

class PFinalApp extends StatefulWidget {
  const PFinalApp({Key? key}) : super(key: key);

  @override
  State<PFinalApp> createState() => _PFinalAppState();
}

class _PFinalAppState extends State<PFinalApp> {
  NotificationsFirebase? _notificationsFirebase;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState_
    _notificationsFirebase = NotificationsFirebase();
    super.initState();
    PushNotificationService.messagesStream.listen((message) {
      print('MyApp: $message');
      Map<String, dynamic> not = message;
      NotificationsModel notification = NotificationsModel(
          fecha: not['fecha'],
          descripcion: not['descripcion'],
          instructor: not['instructor'],
          mensaje: not['mensaje'],
          titulo: not['titulo'],
          taller: not['taller'],
          to_email: not['to_email']);
      _notificationsFirebase!.insPeopleNotification(notification);
      navigatorKey.currentState?.pushNamed('/message', arguments: message);
      final snackBar = SnackBar(content: Text('Notificacion recibida'));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cento Comunitario',
      home: const SplashScreen(),
      theme: tema.getthemeData(),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      routes: {
        '/home': (BuildContext context) => HomeScreen(),
        '/homeS': (BuildContext context) => HomeScreenSocial(),
        '/login': (BuildContext context) => LoginScreen(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/profileS': (BuildContext context) => ProfilePageSocial(),
        '/editImage': (BuildContext context) => EditImagePage(),
        '/theme': (BuildContext context) => ThemeScreen(),
        '/onboarding': (BuildContext context) => OnboardingScreen(),
        '/signup': (BuildContext context) => SignUpScreen(),
        '/message': (BuildContext context) => MessageScreen(),
        '/notification': (BuildContext context) => NotificationScreen(),
      },
    );
  }
}
