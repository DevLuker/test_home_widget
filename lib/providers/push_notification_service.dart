import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_home_widget/firebase_options.dart';

class PushNotifications {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController<String>.broadcast();

  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    log('onBackgroundMessage: ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _messageHandler(RemoteMessage message) async {
    log('onMessageHandler: ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _messageOpenedAppHandler(RemoteMessage message) async {
    log('onOpenAppHandler: ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    token = await FirebaseMessaging.instance.getToken();
    log('TOKEN DEL USUARIO: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_messageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_messageOpenedAppHandler);
  }

  static closeStreams() {
    _messageStream.close();
  }
}
