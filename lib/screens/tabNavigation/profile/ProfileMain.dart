import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xingyuan/screens/tabNavigation/profile/widgets/ProfileButton.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String nickname = '';
  int coins = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((res) {
      final QuerySnapshot<Map<String, dynamic>> usersArray = res;
      setState(() {
        nickname = usersArray.docs.first.get('nickname');
        coins = usersArray.docs.first.get('coins');
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
                  await FirebaseAuth.instance.signOut();
                  print(FirebaseAuth.instance.currentUser);
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
