import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/screens/authentication/AuthenticationPage.dart';
import 'package:xingyuan/screens/authentication/PersonalInfo.dart';
import 'package:xingyuan/screens/tabNavigation/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xingyuan/screens/tabNavigation/wish/AddWish.dart';

// Start refactoring to use node.js backend
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTW',
      theme: ThemeData(
        primaryColor: Colors.pink[200],
      ),
      routes: {
        AuthenticationPage.routeName: (_) => AuthenticationPage(),
        PersonalInfo.routeName: (_) => PersonalInfo(),
        HomePage.routeName: (_) => HomePage(),
        AddWishPage.routeName: (_) => AddWishPage(),
      },
    );
  }
}
