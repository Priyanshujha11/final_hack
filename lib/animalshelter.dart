import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AnimalSheltersPage extends StatefulWidget {
  @override
  _AnimalSheltersPageState createState() => _AnimalSheltersPageState();
}

class _AnimalSheltersPageState extends State<AnimalSheltersPage> {
  final sheltersRef = FirebaseFirestore.instance.collection('animalShelters');
  final donationsRef = FirebaseFirestore.instance.collection('donations');

  dynamic shelters = [];

  @override
  void initState() {
    super.initState();
    sheltersRef.get().then((event) {
      //print(event.docs.toString());
      setState(() {
        shelters = event.docs.toList();
      });
    });
  }

  Future<void> donateToShelter(String shelterKey, String foodItem) async {
    await donationsRef.doc().set({
      'shelter': shelterKey,
      'foodItem': foodItem,
      'timestamp': DateTime.now().toIso8601String(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Donation sent'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? selectedFoodItem;
    changeVal(String value) {
      setState(() {
        selectedFoodItem = value;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Shelters'),
      ),
      body: ListView.builder(
        itemCount: shelters.length,
        itemBuilder: (context, index) {
          String shelterKey = shelters[index]['key'];
          String shelterName = shelters[index]['name'];
          String shelterLocation = shelters[index]['location'];
          List<dynamic> acceptedItems = shelters[index]['acceptedItems'];
          selectedFoodItem = acceptedItems[0];
          print(selectedFoodItem);
          return Card(
            child: ListTile(
              title: Text(shelterName),
              subtitle: Text(shelterLocation),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Donate to $shelterName'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select the food item to donate:'),
                            SizedBox(height: 10),
                            DropdownButton<String>(
                              value: selectedFoodItem,
                              isExpanded: true,
                              items:
                                  acceptedItems.map<DropdownMenuItem<String>>(
                                (item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                changeVal(value!);
                              },
                              hint: Text('Select a food item'),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          ElevatedButton(
                            child: Text('Donate'),
                            onPressed: selectedFoodItem != null
                                ? () async {
                                    await donateToShelter(shelterKey,
                                        selectedFoodItem.toString());
                                    Navigator.of(context).pop();
                                  }
                                : null,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
