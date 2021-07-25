import 'package:flutter/material.dart';

class ReturnMain extends StatelessWidget {
  const ReturnMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WTW'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/returnmain.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
