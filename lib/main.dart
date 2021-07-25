import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTW',
      theme: ThemeData(
        primaryColor: Colors.pink[200],
      ),
      routes: {
        '/': (_) {
          // WHEN NAVIGATING TO HOME PAGE, REMEMBER TO PUSH '/' ROUTE
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
        },
        AddWishPage.routeName: (_) => AddWishPage(),
      },
    );
  }
}
