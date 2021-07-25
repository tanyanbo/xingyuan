import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/common/widgets/InputBox.dart';
import 'package:xingyuan/screens/authentication/MiddleStreamBuilder.dart';

class PersonalInfoArguments {
  String email;
  String code;

  PersonalInfoArguments(this.email, this.code);
}

class PersonalInfo extends StatelessWidget {
  PersonalInfo({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final Map<String, String?> _information = {};

  static const routeName = '/info';

  void submitForm(BuildContext context, PersonalInfoArguments args) async {
    _formKey.currentState!.save();
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: args.email, password: args.code);

    await FirebaseFirestore.instance.collection('users').add(
      {
        'email': args.email,
        'nickname': _information['nickname'],
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'coins': 20,
      },
    );

    await Navigator.of(context).pushNamed(MiddleStreamBuilder.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PersonalInfoArguments;

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
                        title: '昵称:',
                        onSaveHandler: (value) {
                          _information['nickname'] = value;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text('进入WTW！'),
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
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
