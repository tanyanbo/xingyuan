import 'package:flutter/material.dart';

class ReturnMain extends StatelessWidget {
  const ReturnMain({Key? key}) : super(key: key);

  void writePost() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WTW'),
        actions: [
          IconButton(
            onPressed: writePost,
            icon: Icon(
              Icons.rate_review,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
        ],
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
