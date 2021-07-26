import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xingyuan/common/api.dart';

import 'AddWish.dart';

class WishMainArguments {
  int type;

  WishMainArguments(this.type);
}

class WishMain extends StatefulWidget {
  WishMain({Key? key}) : super(key: key);

  @override
  _WishMainState createState() => _WishMainState();
}

class _WishMainState extends State<WishMain> {
  var wishes = [];

  @override
  void initState() {
    super.initState();
    final getWishUrl = Uri.parse('$BASE_URL/wish');
    http.get(
      getWishUrl,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: accessToken,
      },
    ).then((res) {
      final parsed = jsonDecode(res.body);
      if (mounted) {
        setState(() {
          wishes = parsed['data'];
        });
      }
    });
  }

  Future<String?> showMyDialog(BuildContext context, String id) {
    return showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('帮助TA'),
          content: const Text('确定要帮助TA完成心愿吗'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('残忍拒绝'),
            ),
            TextButton(
              onPressed: () async {
                // DocumentSnapshot doc = await wishes.doc(id).get();
                // if (doc['taken']) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text("来晚了...已经有人替TA完成心愿啦"),
                //   ));
                //   Navigator.pop(context, 'OK');
                //   return;
                // }
                // await wishes.doc(id).update({'taken': true});
                // Navigator.pop(context, 'OK');
              },
              child: const Text('帮TA!'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WTW'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/wishmain.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: renderList(),
      ),
    );
  }

  Widget renderList() {
    return Column(
      children: [
        SizedBox(height: 150),
        Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddWishPage.routeName,
                      arguments: WishMainArguments(1));
                },
                icon: Image.asset(
                  'assets/images/1.png',
                ),
                iconSize: 80,
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddWishPage.routeName,
                      arguments: WishMainArguments(2));
                },
                icon: Image.asset(
                  'assets/images/2.png',
                ),
                iconSize: 80,
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddWishPage.routeName,
                      arguments: WishMainArguments(3));
                },
                icon: Image.asset(
                  'assets/images/3.png',
                ),
                iconSize: 80,
              ),
            ),
          ],
        ),
        Flexible(
          child: ListView.builder(
            itemCount: wishes.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> item = wishes[index];
              return Card(
                child: ListTile(
                  title: Text(item['title']),
                  subtitle: Text(
                      '${item['price'].toString()} 心愿币 \n发布人: ${item['user']['nickname']}'),
                  isThreeLine: true,
                  leading: Image(
                    image: AssetImage(
                        'assets/images/${item['type'] == 1 ? 1 : item['type'] == 2 ? 2 : 3}.png'),
                  ),
                  trailing: TextButton(
                    child: Text('我要帮TA！'),
                    onPressed: () {
                      showMyDialog(context, item['id']);
                    },
                  ),
                  tileColor: Colors.white,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
