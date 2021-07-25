import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/screens/authentication/AuthenticationPage.dart';
import 'package:xingyuan/screens/authentication/MiddleStreamBuilder.dart';
import 'package:xingyuan/screens/authentication/PersonalInfo.dart';
import 'package:xingyuan/screens/tabNavigation/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

// Start refactoring to use node.js backend
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  StreamBuilder<User?> authStreamBuilder() {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return AuthenticationPage();
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
        '/': (_) => authStreamBuilder(),
        MiddleStreamBuilder.routeName: (_) => MiddleStreamBuilder(),
        PersonalInfo.routeName: (_) => PersonalInfo(),
      },
    );
  }
}
