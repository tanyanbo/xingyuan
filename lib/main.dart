import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/screens/authentication/AuthenticationPage.dart';
import 'package:xingyuan/screens/authentication/PersonalInfoPage.dart';
import 'package:xingyuan/screens/tabNavigation/HomePage.dart';
import 'package:xingyuan/screens/tabNavigation/profile/MyWishPage.dart';
import 'package:xingyuan/screens/tabNavigation/wish/AddWishPage.dart';

// Start refactoring to use node.js backend
Future<void> main() async {
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
        AuthenticationPage.ROUTE_NAME: (_) => AuthenticationPage(),
        PersonalInfoPage.ROUTE_NAME: (_) => PersonalInfoPage(),
        HomePage.ROUTE_NAME: (_) => HomePage(),
        AddWishPage.ROUTE_NAME: (_) => AddWishPage(),
        MyWishPage.ROUTE_NAME: (_) => MyWishPage(),
      },
    );
  }
}
