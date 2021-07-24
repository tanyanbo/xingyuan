import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/common/items/Wish.dart';

class AddWishPage extends StatefulWidget {
  AddWishPage({Key? key}) : super(key: key);

  @override
  _AddWishPageState createState() => _AddWishPageState();
}

class _AddWishPageState extends State<AddWishPage> {
  final _formKey = GlobalKey<FormState>();
  Wish _editedWish = Wish();

  void submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    await FirebaseFirestore.instance.collection('wishes').add({
      'title': _editedWish.title,
      'price': _editedWish.price,
      'type': _editedWish.type == TypeOfWish.INFO
          ? 1
          : _editedWish.type == TypeOfWish.PHYSICAL
              ? 2
              : 3,
      'date': DateTime.now(),
    });
    Navigator.of(context).pushNamed('/home');
  }

  TypeOfWish? _choice = TypeOfWish.INFO;

  @override
  Widget build(BuildContext context) {
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
                RadioListTile<TypeOfWish>(
                  title: Text('信息咨询'),
                  value: TypeOfWish.INFO,
                  groupValue: _choice,
                  onChanged: (TypeOfWish? val) {
                    setState(() {
                      _choice = val;
                      _editedWish.type = val as TypeOfWish;
                    });
                  },
                ),
                RadioListTile<TypeOfWish>(
                  title: Text('物质获取'),
                  value: TypeOfWish.PHYSICAL,
                  groupValue: _choice,
                  onChanged: (TypeOfWish? val) {
                    setState(() {
                      _choice = val;
                      _editedWish.type = val as TypeOfWish;
                    });
                  },
                ),
                RadioListTile<TypeOfWish>(
                  title: Text('实际行动'),
                  value: TypeOfWish.ACTION,
                  groupValue: _choice,
                  onChanged: (TypeOfWish? val) {
                    setState(() {
                      _choice = val;
                      _editedWish.type = val as TypeOfWish;
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('发布'),
                  onPressed: () => submitForm(context),
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 40)),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
