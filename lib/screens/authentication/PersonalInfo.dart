import 'package:flutter/material.dart';
import 'package:xingyuan/common/widgets/InputBox.dart';
import 'package:xingyuan/screens/tabNavigation/HomePage.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final Map<String, String?> _information = {};

  static const routeName = '/info';

  void submitForm(BuildContext context) async {
    await Navigator.of(context).pushNamed(HomePage.routeName);
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
