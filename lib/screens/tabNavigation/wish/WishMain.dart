import 'package:flutter/material.dart';

class WishMain extends StatelessWidget {
  String title;
  WishMain({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('愿望专区'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/addwish');
            },
            icon: Icon(
              Icons.add_circle_outlined,
              size: 40,
            ),
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
    );
  }
}
