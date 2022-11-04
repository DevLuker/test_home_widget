import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_home_widget/providers/home_provider.dart';
import 'package:flutter_home_widget/screens/screens.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  if (Platform.isIOS) {
    HomeWidget.setAppGroupId('group.home.widget.demo');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Widget Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CronometerScreen(),
    );
  }
}
