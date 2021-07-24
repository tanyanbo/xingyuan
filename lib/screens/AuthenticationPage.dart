import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _formKey = GlobalKey<FormState>();

  void submitForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.of(context).pushNamed('/home');
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
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text('手机号:'),
                          ),
                          prefixStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val == null) {
                            return null;
                          }
                          return val.length == 11 ? null : '请输入11位手机号';
                        },
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text('验证码:'),
                          ),
                          prefixStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
