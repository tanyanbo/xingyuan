import 'package:flutter/material.dart';

class WishingWellPage extends StatelessWidget {
  WishingWellPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/wishingwell';

  Widget post(String name, String content, String time) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.person,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 40),
            Text(content),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 40),
            Spacer(),
            Text(
              time,
              style: TextStyle(color: Colors.black38),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.favorite,
              color: Colors.redAccent,
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          child: Container(
            color: Colors.black26,
          ),
          height: 1,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/return.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.16),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '听说还愿之后有惊喜哦',
                    labelStyle: TextStyle(color: Colors.black26),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: Text('发表')),
                post('魔法少女', '感谢善良的小哥哥替我遛狗', '2小时前'),
                post('明月清风', '感谢远方的你', '5小时前'),
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
        ),
      ),
    );
  }
}
