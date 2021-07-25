import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/screens/AuthenticationPage.dart';
import 'package:xingyuan/screens/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xingyuan/screens/PersonalInfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  StreamBuilder<User?> authStreamBuilder(bool showInfo) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return showInfo ? PersonalInfo() : AuthenticationPage();
          }
          return HomePage();
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTW',
      theme: ThemeData(
        primaryColor: Colors.pink[200],
      ),
      routes: {
        '/': (_) => authStreamBuilder(false),
        '/info': (_) => authStreamBuilder(true),
      },
    );
  }
}
