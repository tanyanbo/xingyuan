import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xingyuan/common/UserStore.dart';
import 'package:xingyuan/common/routes.dart';

class MyWishPage extends StatefulWidget {
  const MyWishPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/mywish';

  @override
  _MyWishPageState createState() => _MyWishPageState();
}

class _MyWishPageState extends State<MyWishPage> {
  Future<http.Response> getOwnWish() {
    Uri getWishPersonUrl = Uri.parse('$BASE_URL/wish/${UserStore().id}');
    return http.get(
      getWishPersonUrl,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: UserStore().accessToken,
      },
    );
  }

  Future<String?> showMyDialog(BuildContext context, String id) {
    return showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('心愿已完成'),
          content: const Text('确认心愿已完成'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('未完成'),
            ),
            TextButton(
              onPressed: () async {
                await http.put(
                  updateWishUrl,
                  body: json.encode({
                    "wishId": id,
                    "completed": true,
                  }),
                  headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                    HttpHeaders.authorizationHeader: UserStore().accessToken,
                  },
                );

                Navigator.pop(context, 'Ok');
                setState(() {});
              },
              child: const Text('已完成!'),
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
              'assets/images/profilemain.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                '我的心愿',
                style: TextStyle(fontSize: 30),
              ),
              FutureBuilder(
                future: getOwnWish(),
                builder: (BuildContext context,
                    AsyncSnapshot<http.Response> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final parsed = jsonDecode(snapshot.data!.body);
                      final data = parsed['data'];
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> item = data[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  item['title'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: item['completed'],
                                subtitle: Text(
                                  '${item['price'].toString()} 心愿币${item['completed'] ? '\n已完成！' : ''}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: Image(
                                  image: AssetImage(
                                      'assets/images/${item['type'] == 1 ? 1 : item['type'] == 2 ? 2 : 3}.png'),
                                ),
                                trailing: SizedBox(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      item['taken'] && !item['completed']
                                          ? TextButton(
                                              onPressed: () {
                                                showMyDialog(
                                                    context, item['id']);
                                              },
                                              child: Text('已完成！'),
                                            )
                                          : Container(),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          Uri deleteWishUrl = Uri.parse(
                                              '$BASE_URL/wish/${item['id']}');
                                          await http.delete(
                                            deleteWishUrl,
                                            headers: {
                                              HttpHeaders.contentTypeHeader:
                                                  'application/json',
                                              HttpHeaders.authorizationHeader:
                                                  UserStore().accessToken,
                                            },
                                          );
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                tileColor: Colors.white,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('无法获取心愿');
                    }
                    return Text('无法获取心愿');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
