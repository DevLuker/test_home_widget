import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_home_widget/providers/home_provider.dart';
import 'package:flutter_home_widget/providers/push_notification_service.dart';
import 'package:flutter_home_widget/screens/screens.dart';
import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';
//HomeWidget.registerBackgroundCallback(backgroundCallback);

void callbackDispatcher() async {
  Workmanager().executeTask((taskName, inputData) async {
    // if (taskName == 'simpleTask') {
    // Llamar a la función que actualiza el widget
    // }
    await initHomeWidgetData();
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Firebase
  await PushNotifications.initializeApp();

  // Init WorkManager
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // Init Home Widget IOS
  if (Platform.isIOS) {
    await HomeWidget.setAppGroupId('group.home.widget.devpianist');
    await Workmanager().registerOneOffTask(
      'simpleTask',
      'simpleTask',
    );
  }

  if (Platform.isAndroid) {
    await Workmanager().registerPeriodicTask(
      'simpleTask',
      'simpleTask',
      frequency: const Duration(minutes: 15),
    );
  }
  await initHomeWidgetData();

  // Init App
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
      navigatorKey.currentState?.pushNamed('home', arguments: event);
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
      home: const WidgetScreen(),
    );
  }
}
