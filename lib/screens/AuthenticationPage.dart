import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('星愿'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('登录'),
          ),
          Center(
            child: ElevatedButton(
              child: Text('登录'),
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
