import 'package:flutter/material.dart';
import 'package:xingyuan/screens/AuthenticationPage.dart';
import 'package:xingyuan/screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pink[200],
      ),
      routes: {
        '/': (_) => AuthenticationPage(),
        '/home': (_) => HomePage(title: '星愿'),
      },
    );
  }
}
