import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//fbo_dlfXQ96aEOw65geCL6:APA91bF2JuxI587hm0YNprXo-k0nqYUOuJMTfQgbvH6iYaV2voLgVGXEEJIuUSMKLaZSv1XlejG19cDL6glE3GMmtrQWfPl_raRM7pJ_JEkMeZH8FaAevnGhKKRSjluky09RGxNENwdF
class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print('background handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('background handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('background handler ${message.messageId}');
    _messageStream.add(message.notification?.title ?? 'No title');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('token: $token');

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
