import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:xingyuan/common/InputBox.dart';
import 'package:xingyuan/screens/authentication/PersonalInfo.dart';

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

    QuerySnapshot<Object?> docs = await users
        .where('email', isEqualTo: '${_credentials['phoneNumber']}@email.com')
        .get();

    if (docs.docs.length == 0) {
      Navigator.of(context).pushNamed(
        PersonalInfo.routeName,
        arguments: PersonalInfoArguments(
          '${_credentials['phoneNumber']}@email.com',
          _credentials['code'] as String,
        ),
      );
      return;
    }

    try {
      await auth.signInWithEmailAndPassword(
        email: "${_credentials['phoneNumber'] as String}@email.com",
        password: _credentials['code'] as String,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        showMyDialog(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
