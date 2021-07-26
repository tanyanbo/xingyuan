import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:xingyuan/common/api.dart';
import 'package:xingyuan/common/widgets/InputBox.dart';
import 'package:http/http.dart' as http;
import 'package:xingyuan/screens/tabNavigation/HomePage.dart';
import 'dart:convert';

import 'PersonalInfo.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final Map<String, String?> _credentials = {};
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<String?> showMyDialog(BuildContext context) {
    return showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('验证失败'),
          content: const Text('密码错误'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Ok');
              },
              child: const Text('重新输入'),
            ),
          ],
        );
      },
    );
  }

  void submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final Uri signInUrl = Uri.parse('$BASE_URL/signin');

    final http.Response res = await http.post(
      signInUrl,
      body: json.encode({
        "phone": _credentials['phoneNumber'],
        "code": _credentials['code'],
      }),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    final parsed = jsonDecode(res.body) as Map<String, dynamic>;

    if (parsed["isNewUser"]) {
      await Navigator.of(context).pushNamed(PersonalInfo.routeName);
    } else {
      await Navigator.of(context).pushNamed(HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cover.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      InputBox(
                        title: '手机号:',
                        onSaveHandler: (value) {
                          _credentials['phoneNumber'] = value;
                        },
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          return val == null
                              ? null
                              : val.length == 11
                                  ? null
                                  : '请输入11位手机号';
                        },
                      ),
                      SizedBox(height: 20),
                      InputBox(
                        title: '验证码:',
                        onSaveHandler: (value) {
                          _credentials['code'] = value;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text('登录'),
                        onPressed: () => submitForm(context),
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
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
