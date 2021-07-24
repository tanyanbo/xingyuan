import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishMain extends StatelessWidget {
  final String title;

  WishMain({Key? key, required this.title}) : super(key: key);

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
        stream: FirebaseFirestore.instance.collection('/wishes').snapshots(),
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
                  leading: Icon(
                    Icons.add_location_alt_outlined,
                    size: 50,
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
