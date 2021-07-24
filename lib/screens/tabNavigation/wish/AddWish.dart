import 'package:flutter/material.dart';

class AddWishPage extends StatelessWidget {
  const AddWishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加新愿望'),
      ),
      body: Container(
        child: Center(
          child: Text("在这里许愿哦"),
        ),
      ),
    );
  }
}
