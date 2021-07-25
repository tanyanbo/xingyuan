import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/common/items/Wish.dart';
import 'package:xingyuan/screens/tabNavigation/wish/WishMain.dart';

class AddWishPage extends StatefulWidget {
  AddWishPage({Key? key}) : super(key: key);

  static const routeName = '/addWish';

  @override
  _AddWishPageState createState() => _AddWishPageState();
}

class _AddWishPageState extends State<AddWishPage> {
  final _formKey = GlobalKey<FormState>();
  Wish _editedWish = Wish(user: {
    "uid": FirebaseAuth.instance.currentUser!.uid,
    "email": FirebaseAuth.instance.currentUser!.email
  });

  void submitForm(BuildContext context, WishMainArguments args) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final usersArray = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();

    await FirebaseFirestore.instance.collection('wishes').add({
      'title': _editedWish.title,
      'price': _editedWish.price,
      'type': args.type,
      'date': DateTime.now(),
      'taken': false,
      'completed': false,
      'user': {
        'databaseId': usersArray.docs[0].id,
        'nickname': usersArray.docs[0]['nickname'],
      },
    });
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as WishMainArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('添加新愿望'),
      ),
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '心愿',
                    ),
                    onSaved: (String? value) {
                      _editedWish.title = value as String;
                    },
                    validator: (val) {
                      return val == '' ? '请输入心愿哦' : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '报酬',
                    ),
                    onSaved: (String? value) {
                      _editedWish.price = int.parse(value as String);
                    },
                    validator: (val) {
                      return val == '' ? '给别人一些报酬啊' : null;
                    },
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  ElevatedButton(
                    child: Text('发布'),
                    onPressed: () => submitForm(context, args),
                    style: ElevatedButton.styleFrom(minimumSize: Size(200, 40)),
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
