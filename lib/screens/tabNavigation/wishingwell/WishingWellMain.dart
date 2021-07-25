import 'package:flutter/material.dart';

class WishingWellMain extends StatelessWidget {
  const WishingWellMain({Key? key}) : super(key: key);

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
              'assets/images/wishingwellmain.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
