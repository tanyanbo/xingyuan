import 'package:flutter/material.dart';
import 'package:xingyuan/screens/tabNavigation/wishingwell/WishingWellPage.dart';

class WishingWellMain extends StatelessWidget {
  const WishingWellMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/wishingwellmain.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: ElevatedButton(
              child: Text('许愿'),
              onPressed: () {
                Navigator.of(context).pushNamed(WishingWellPage.ROUTE_NAME);
              },
            ),
          ),
        ),
      ),
    );
  }
}
