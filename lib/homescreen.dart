import 'package:final_hack/animalshelter.dart';
import 'package:final_hack/hungerreliforg.dart';
import 'package:final_hack/processing.dart';
import 'package:final_hack/restaurantsection.dart';
import 'package:final_hack/supermarketscreen.dart';
import 'package:final_hack/where.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 242, 243, 248),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Food Rescue',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => SupermarketScreen()),
                      ),
                    );
                  },
                  child: Card(
                    //color: Color.fromARGB(255, 38, 51, 197),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(80),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            tileMode: TileMode.repeated,
                            stops: [0.1, 0.8, 0.9],
                            begin: Alignment.topCenter,
                            colors: [
                              Color.fromARGB(255, 219, 145, 34)
                                  .withOpacity(0.5),
                              Color.fromARGB(255, 219, 145, 34)
                                  .withOpacity(0.8),
                              Color.fromARGB(255, 219, 145, 34)
                                  .withOpacity(0.9),
                            ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(80),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Center(
                        child: Text(
                          'Supermarkets',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => AnimalSheltersPage()),
                      ),
                    );
                  },
                  child: Card(
                    //color: Color.fromARGB(255, 38, 51, 197),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(80),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),

                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            tileMode: TileMode.repeated,
                            stops: [0.1, 0.8, 0.9],
                            begin: Alignment.topCenter,
                            colors: [
                              Color.fromARGB(255, 38, 51, 197).withOpacity(0.5),
                              Color.fromARGB(255, 38, 51, 197).withOpacity(0.8),
                              Color.fromARGB(255, 38, 51, 197).withOpacity(0.9),
                            ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(80),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Center(
                        child: Text(
                          'Animal-Shelter',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => RestaurantScreen()),
                      ),
                    );
                  },
                  child: Card(
                    //color: Color.fromARGB(255, 38, 51, 197),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(80),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),

                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            tileMode: TileMode.repeated,
                            stops: [0.1, 0.8, 0.9],
                            begin: Alignment.topCenter,
                            colors: [
                              Color.fromARGB(255, 207, 117, 194)
                                  .withOpacity(0.5),
                              Color.fromARGB(255, 207, 117, 194)
                                  .withOpacity(0.8),
                              Color.fromARGB(255, 207, 117, 194)
                                  .withOpacity(0.9),
                            ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(80),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Center(
                        child: Text(
                          'Restaurants',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) =>
                            HungerReliefOrganizationScreen()),
                      ),
                    );
                  },
                  child: Card(
                    //color: Color.fromARGB(255, 38, 51, 197),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(80),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),

                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            tileMode: TileMode.repeated,
                            stops: [0.1, 0.8, 0.9],
                            begin: Alignment.topCenter,
                            colors: [
                              Color.fromARGB(255, 10, 45, 106).withOpacity(0.5),
                              Color.fromARGB(255, 10, 45, 106).withOpacity(0.8),
                              Color.fromARGB(255, 10, 45, 106).withOpacity(0.9),
                            ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(80),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Center(
                        child: Text(
                          'Hunger-Relief\nOrganizations',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topRight: Radius.circular(80),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  elevation: 10,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                  topRight: Radius.circular(80),
                                  bottomLeft: Radius.circular(12),
                                ),
                                gradient: LinearGradient(
                                    tileMode: TileMode.repeated,
                                    stops: [0.1, 0.8, 0.9],
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Color.fromARGB(255, 38, 51, 197)
                                          .withOpacity(0.5),
                                      Color.fromARGB(255, 38, 51, 197)
                                          .withOpacity(0.8),
                                      Color.fromARGB(255, 38, 51, 197)
                                          .withOpacity(0.9),
                                    ]),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    '  Where can you find us',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 35.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AboutPage()));
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.info,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'About us',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launchUrlString(
                                            'https://www.linkedin.com/company/devify16/',
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.linkedin,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Linkedin',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launchUrlString(
                                            'https://instagram.com/dev.ify?igshid=YmMyMTA2M2Y=',
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.instagram,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Instagram',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launchUrlString(
                                            'https://devify.co.in',
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.database,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Website',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
