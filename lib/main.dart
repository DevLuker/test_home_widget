import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_home_widget/firebase_options.dart';
import 'package:flutter_home_widget/providers/home_provider.dart';
import 'package:flutter_home_widget/providers/push_notification_service.dart';
import 'package:flutter_home_widget/screens/example_screen.dart';
import 'package:flutter_home_widget/screens/screens.dart';
import 'package:home_widget/home_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PushNotifications.initializeApp();

  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotifications.messagesStream.listen((event) {
      print('EVENTO: $event');

      navigatorKey.currentState?.pushNamed('example', arguments: event);

      scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(event),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Widget Counter',
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CronometerScreen(),
      routes: {
        'example': (context) => const ExampleScreen(),
      },
    );
  }
}
