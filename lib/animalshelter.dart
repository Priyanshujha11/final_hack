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
      'food': foodItem,
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
              'Animal Shelters',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: shelters.length,
        itemBuilder: (context, index) {
          String shelterKey = shelters[index]['key'];
          String shelterName = shelters[index]['name'];
          String shelterLocation = shelters[index]['location'];
          List<dynamic> acceptedItems = shelters[index]['acceptedItems'];
          String selectedFoodItem = acceptedItems[0].toString();
          print(selectedFoodItem);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Donate to $shelterName'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Select the food item to donate:'),
                          SizedBox(height: 10),
                          StatefulBuilder(
                              builder: (context, StateSetter setState) {
                            return DropdownButton<String>(
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
                                setState(
                                  () {
                                    selectedFoodItem = value!;
                                  },
                                );
                              },
                              hint: Text('Select a food item'),
                            );
                          }),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color.fromARGB(255, 38, 51, 197),
                            ),
                          ),
                          style: TextButton.styleFrom(
                              textStyle: TextStyle(
                            color: Color.fromARGB(255, 38, 51, 197),
                          )),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 38, 51, 197),
                          ),
                          child: Text('Donate'),
                          onPressed: selectedFoodItem != null
                              ? () async {
                                  await donateToShelter(
                                      shelterKey, selectedFoodItem.toString());
                                  Navigator.of(context).pop();
                                }
                              : null,
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 10,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shelterName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  shelterLocation,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20, top: 5),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 38, 51, 197),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
