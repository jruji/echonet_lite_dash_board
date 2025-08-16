import '../view/views.dart';
import 'package:flutter/material.dart';
import '../config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iHouse Dashboard',
      home: GetNavigator(),
    );
  }
}
