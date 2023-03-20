import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupermarketScreen extends StatelessWidget {
  const SupermarketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supermarkets'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('supermarkets').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot supermarket = snapshot.data!.docs[index];
              return ListTile(
                title: Text(supermarket['name']),
                subtitle: Text(supermarket['address']),
                trailing: Text(supermarket['phone']),
              );
            },
          );
        },
      ),
    );
  }
}
