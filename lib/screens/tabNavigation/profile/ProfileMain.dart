import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xingyuan/common/UserStore.dart';
import 'package:xingyuan/common/routes.dart';
import 'package:xingyuan/screens/authentication/AuthenticationPage.dart';
import 'package:xingyuan/screens/tabNavigation/profile/MyWishPage.dart';
import 'package:xingyuan/screens/tabNavigation/profile/widgets/ProfileButton.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  bool isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = UserStore();
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
        child: isLoggingOut
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  children: [
                    SizedBox(height: 100),
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
                              userStore.nickname,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('${userStore.coins} 心愿币'),
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
                      onPressHandler: () async {
                        await Navigator.of(context)
                            .pushNamed(MyWishPage.ROUTE_NAME);
                      },
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
                      onPressHandler: () {
                        final storage = new FlutterSecureStorage();
                        http.get(signOutUrl, headers: {
                          HttpHeaders.contentTypeHeader: 'application/json',
                          HttpHeaders.authorizationHeader:
                              UserStore().accessToken,
                        }).then((value) {
                          storage.delete(key: 'access_token').then((value) {
                            Navigator.of(context).pushReplacementNamed(
                                AuthenticationPage.ROUTE_NAME);
                          });
                        });
                        setState(() {
                          isLoggingOut = true;
                        });
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
