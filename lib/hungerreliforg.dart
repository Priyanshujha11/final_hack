import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HungerReliefOrganizationScreen extends StatefulWidget {
  const HungerReliefOrganizationScreen({Key? key}) : super(key: key);

  @override
  _HungerReliefOrganizationScreenState createState() =>
      _HungerReliefOrganizationScreenState();
}

class _HungerReliefOrganizationScreenState
    extends State<HungerReliefOrganizationScreen> {
  final TextEditingController _foodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hunger Relief Organization'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _foodController,
            decoration: InputDecoration(
              labelText: 'Food to Donate',
              hintText: 'Enter food item(s) separated by commas',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String food = _foodController.text.trim();
              if (food.isNotEmpty) {
                FirebaseFirestore.instance.collection('donations').add({
                  'food': food,
                  'timestamp': DateTime.now(),
                }).then((value) {
                  _foodController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Food donation added successfully.'),
                  ));
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to add food donation.'),
                  ));
                });
              }
            },
            child: Text('Donate Food'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('donations')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('No Donations Yet!!'),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = documents[index];

                    return ListTile(
                      title: Text(document['food']),
                      subtitle: Text(document['timestamp'].toString()),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('organizations')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to fetch organizations.'),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = documents[index];

                    return ListTile(
                      title: Text(document['name']),
                      subtitle: Text(document['address']),
                      trailing: ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('donations')
                              .add({
                            'food': document['food'],
                            'organization': document['name'],
                            'timestamp': DateTime.now(),
                          }).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Food donation sent to ${document['name']}'),
                            ));
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to send food donation.'),
                            ));
                          });
                        },
                        child: Text('Donate'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
