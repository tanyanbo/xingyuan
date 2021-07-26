import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xingyuan/common/api.dart';
import 'package:http/http.dart' as http;
import 'package:xingyuan/common/widgets/InputBox.dart';
import 'package:xingyuan/screens/tabNavigation/HomePage.dart';
import 'package:xingyuan/screens/tabNavigation/wish/WishMain.dart';

class AddWishPage extends StatelessWidget {
  AddWishPage({Key? key}) : super(key: key);

  static const routeName = '/addWish';

  final _formKey = GlobalKey<FormState>();
  final _info = {};

  void submitForm(BuildContext context, WishMainArguments args) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final Uri addWishUrl = Uri.parse('$BASE_URL/wish');

    await http.post(
      addWishUrl,
      body: json.encode({
        "title": _info['title'],
        "price": _info['price'],
        "type": args.type,
        "date": DateTime.now().toUtc().millisecondsSinceEpoch,
        "taken": false,
        "completed": false,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: accessToken,
      },
    );
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as WishMainArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('添加新愿望'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/wishmain.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 150),
                  InputBox(
                    title: '心愿',
                    onSaveHandler: (String? value) {
                      _info['title'] = value as String;
                    },
                    validator: (val) {
                      return val == '' ? '请输入心愿哦' : null;
                    },
                  ),
                  SizedBox(height: 10),
                  InputBox(
                    title: '报酬',
                    onSaveHandler: (String? value) {
                      _info['price'] = int.parse(value as String);
                    },
                    validator: (val) {
                      return val == '' ? '给别人一些报酬啊' : null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('发布'),
                    onPressed: () => submitForm(context, args),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 40),
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
