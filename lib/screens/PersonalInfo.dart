import 'package:flutter/material.dart';
import 'package:xingyuan/common/InputBox.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final Map<String, String?> _information = {};

  void submitForm(BuildContext context) async {
    _formKey.currentState!.save();
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
                        title: '昵称:',
                        onSaveHandler: (value) {
                          _information['nickname'] = value;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text('进入WTW！'),
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
