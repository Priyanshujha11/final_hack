import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProcessingScreen extends StatelessWidget {
  const ProcessingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
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
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waste Food Processing Options',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                decorationStyle: TextDecorationStyle.double,
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Composting:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Composting is the process of breaking down organic waste, such as food scraps and yard waste, into a nutrient-rich soil amendment that can be used to improve soil health and plant growth. You can learn how to start composting at home by visiting https://www.epa.gov/recycle/composting-home.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Other Processing Options:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'There are many other ways to process waste food, such as anaerobic digestion, which involves breaking down food waste in the absence of oxygen to produce biogas, and incineration, which burns waste to generate energy. To learn more about these options, please visit your local waste management authority or environmental organization.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 38, 51, 197)),
              onPressed: () {
                launchUrlString(
                    'https://mohua.gov.in/upload/uploadfiles/files/chap14(1).pdf');
              },
              child: Container(
                  height: 50,
                  child: Center(child: Text('For more Information'))),
            ),
          ],
        ),
      ),
    );
  }
}
