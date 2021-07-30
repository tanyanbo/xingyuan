import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xingyuan/common/UserStore.dart';
import 'package:xingyuan/common/routes.dart';

class MyWishPage extends StatelessWidget {
  const MyWishPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/mywish';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text('我的心愿'),
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
                                title: Text(item['title']),
                                subtitle:
                                    Text('${item['price'].toString()} 心愿币'),
                                leading: Image(
                                  image: AssetImage(
                                      'assets/images/${item['type'] == 1 ? 1 : item['type'] == 2 ? 2 : 3}.png'),
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
