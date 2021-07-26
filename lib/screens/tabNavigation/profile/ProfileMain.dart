import 'package:flutter/material.dart';
import 'package:xingyuan/common/api.dart';
import 'package:xingyuan/screens/authentication/AuthenticationPage.dart';
import 'package:xingyuan/screens/tabNavigation/profile/widgets/ProfileButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  String nickname = '';
  int coins = 0;

  @override
  void initState() {
    super.initState();
    final Uri getInfoUrl = Uri.parse('$BASE_URL/info');
    print(getInfoUrl);

    http.get(
      getInfoUrl,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: accessToken,
      },
    ).then((res) {
      final parsed = jsonDecode(res.body) as Map<String, dynamic>;
      final data = parsed['data'];
      setState(() {
        nickname = data['nickname'];
        coins = data['coins'];
      });
    });
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
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      Text(
                        nickname.isEmpty ? '' : nickname,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('${nickname.isEmpty ? '' : coins} 心愿币'),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                ),
              ),
              ProfileButton(
                onPressHandler: () {},
                icon: Icons.favorite,
                iconColor: Colors.pink,
                text: '我的心愿',
              ),
              ProfileButton(
                onPressHandler: () {},
                icon: Icons.volunteer_activism,
                text: '我完成的心愿',
              ),
              ProfileButton(
                onPressHandler: () {},
                icon: Icons.monetization_on,
                text: '购买',
              ),
              ProfileButton(
                onPressHandler: () {},
                icon: Icons.card_giftcard,
                text: '兑换',
              ),
              SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                ),
              ),
              ProfileButton(
                onPressHandler: () async {
                  final signOutUrl = Uri.parse('$BASE_URL/signout');
                  await http.get(signOutUrl, headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                    HttpHeaders.authorizationHeader: accessToken,
                  });
                  await Navigator.of(context)
                      .pushReplacementNamed(AuthenticationPage.routeName);
                },
                icon: Icons.exit_to_app,
                text: '退出',
              )
            ],
          ),
        ),
      ),
    );
  }
}
