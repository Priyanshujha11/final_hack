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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              'Human Relief',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _foodController,
              decoration: InputDecoration(
                labelText: 'Food to Donate',
                hintText: 'Enter food item(s) separated by commas',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 38, 51, 197)),
              onPressed: () {
                String food = _foodController.text.trim();
                if (food.isNotEmpty) {
                  FirebaseFirestore.instance.collection('donations').add({
                    'food': food,
                    'timestamp': DateTime.now().day.toString() +
                        '/' +
                        DateTime.now().month.toString(),
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
              child: Container(
                  height: 50, child: Center(child: Text('Donate Food'))),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'List of Food Donated: ',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
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

                      return Card(
                        elevation: 10,
                        child: ListTile(
                          leading: Text(
                            (1 + index).toString() + ". ",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          title: Text(
                            document['food'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                          subtitle: Text(
                            'Date: ' + document['timestamp'].toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'List of Organizations:',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
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

                      return Card(
                        elevation: 10,
                        child: ListTile(
                          title: Text(document['name']),
                          subtitle: Text(document['address']),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 38, 51, 197)),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('donations')
                                  .add({
                                'food': document['food'],
                                'organization': document['name'],
                                'timestamp': DateTime.now(),
                              }).then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Food donation sent to ${document['name']}'),
                                ));
                              }).catchError((error) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Failed to send food donation.'),
                                ));
                              });
                            },
                            child: Text('Donate'),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
