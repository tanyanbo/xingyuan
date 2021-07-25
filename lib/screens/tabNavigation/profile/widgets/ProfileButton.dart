import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final void Function() onPressHandler;
  final IconData icon;
  final Color iconColor;
  final String text;

  ProfileButton({
    Key? key,
    required this.onPressHandler,
    required this.icon,
    this.iconColor = Colors.black,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressHandler,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.black26,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}
