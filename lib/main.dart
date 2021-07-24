import 'package:flutter/material.dart';
import 'package:xingyuan/screens/AuthenticationPage.dart';
import 'package:xingyuan/screens/HomePage.dart';
import 'package:xingyuan/screens/tabNavigation/wish/AddWish.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '星愿',
      theme: ThemeData(
        primaryColor: Colors.pink[200],
      ),
      routes: {
        '/': (_) => AuthenticationPage(),
        '/home': (_) => HomePage(title: '星愿'),
        '/addwish': (_) => AddWishPage(),
      },
    );
  }
}
