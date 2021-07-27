import 'dart:io';
import 'package:flutter/material.dart';
import 'package:xingyuan/common/UserStore.dart';
import 'package:xingyuan/common/widgets/InputBox.dart';
import 'package:xingyuan/screens/tabNavigation/HomePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key? key}) : super(key: key);
  static const routeName = '/info';

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String?> _information = {};

  final nicknameUrl = Uri.parse('$BASE_URL/nickname');

  bool isLoading = false;

  void submitForm(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    _formKey.currentState!.save();
    try {
      http.post(
        nicknameUrl,
        body: json.encode({
          "nickname": _information['nickname'],
        }),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: UserStore().accessToken
        },
      ).then((res) {
        final parsed = jsonDecode(res.body) as Map<String, dynamic>;
        final data = parsed['data'];
        UserStore(nickname: data['nickname'], coins: data['coins']);
      });
    } catch (e) {
      return;
    }
    await Navigator.of(context).pushNamed(HomePage.routeName);
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
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
