import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishMain extends StatelessWidget {
  final String title;

  WishMain({Key? key, required this.title}) : super(key: key);

  CollectionReference wishes = FirebaseFirestore.instance.collection('wishes');

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
                DocumentSnapshot doc = await wishes.doc(id).get();
                if (doc['taken']) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("来晚了...已经有人替TA完成心愿啦"),
                  ));
                  Navigator.pop(context, 'OK');
                  return;
                }
                await wishes.doc(id).update({'taken': true});
                Navigator.pop(context, 'OK');
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
        title: Text('愿望专区'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/addwish');
            },
            icon: Icon(
              Icons.add_circle_outlined,
              size: 40,
            ),
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/wishes')
            .where('taken', isEqualTo: false)
            .where('completed', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData ||
              snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.requireData.docs.length,
            itemBuilder: (BuildContext context, int index) {
              QueryDocumentSnapshot<Map<String, dynamic>> item =
                  snapshot.requireData.docs[index];
              return Card(
                child: ListTile(
                  title: Text(item['title']),
                  subtitle: Text(item['price'].toString()),
                  leading: Image(
                    image: AssetImage(
                        'assets/images/${item['type'] == 1 ? 1 : item['type'] == 2 ? 2 : 3}.png'),
                  ),
                  trailing: TextButton(
                    child: Text('我要帮TA！'),
                    onPressed: () {
                      showMyDialog(context, item.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
