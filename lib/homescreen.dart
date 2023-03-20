import 'package:final_hack/animalshelter.dart';
import 'package:final_hack/hungerreliforg.dart';
import 'package:final_hack/processing.dart';
import 'package:final_hack/restaurantsection.dart';
import 'package:final_hack/supermarketscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _initialized = false;
  bool _error = false;

  Future<void> initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set _initialized to true

      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set _error to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Scaffold(
        body: Center(
          child: Text('Error initializing Firebase'),
        ),
      );
    }

    if (!_initialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Zero Food Waste System'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => SupermarketScreen())));
            },
            child: Text('Supermarkets'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ProcessingScreen())));
            },
            child: Text('Processing'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => AnimalSheltersPage())));
            },
            child: Text('Animal Shelter'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => RestaurantScreen())));
            },
            child: Text('Restaurants'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          HungerReliefOrganizationScreen())));
            },
            child: Text('Hunger Relief Organizations'),
          ),
        ],
      ),
    );
  }
}
