import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/screens/tabNavigation/HomePage.dart';
import 'AuthenticationPage.dart';

class MiddleStreamBuilder extends StatelessWidget {
  MiddleStreamBuilder({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  static const routeName = '/middleware';

  @override
  Widget build(BuildContext context) {
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
}
