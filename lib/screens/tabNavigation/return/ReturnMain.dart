import 'package:flutter/material.dart';

class ReturnMain extends StatelessWidget {
  const ReturnMain({Key? key}) : super(key: key);

  void writePost() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/returnmain.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
