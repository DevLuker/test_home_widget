import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController<String>.broadcast();

  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    print('onBackgroundMessage: ${message.messageId}');

    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _messageHandler(RemoteMessage message) async {
    print('onMessageHandler: ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
    //_messageStream.add(message.notification?.title ?? 'No data 2');
  }

  static Future _messageOpenedAppHandler(RemoteMessage message) async {
    print('onOpenAppHandler: ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
    //_messageStream.add(message.notification?.title ?? 'No data 3');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN DEL USUARIO: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_messageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_messageOpenedAppHandler);

    // Local Notifications
  }

  static closeStreams() {
    _messageStream.close();
  }
}
