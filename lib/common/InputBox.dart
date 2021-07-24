import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String title;
  final void Function(String?) onSaveHandler;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const InputBox(
      {Key? key,
      required this.title,
      required this.onSaveHandler,
      this.validator,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: EdgeInsets.all(15),
          child: Text(title),
        ),
        prefixStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 10,
        ),
        focusedBorder: OutlineInputBorder(),
        errorStyle: TextStyle(color: Colors.yellow),
      ),
      keyboardType: keyboardType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: onSaveHandler,
    );
  }
}
