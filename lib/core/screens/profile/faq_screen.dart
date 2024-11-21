// do something
import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Frequently Asked Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perhaps we already have what you’re looking for! Refer to the questions and answers below to find your solution. Otherwise, please don’t hesitate to contact us!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ExpansionTile(
                    title: Text('What is the LeafoIyze?'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Lorem ipsum dolor amet, consectetur adipiscing elit. Sodales proin luctus vestibulum leo fames elementum adipiscing. Laoreet tempor ex ex lobortis justo porta. Curabitur eros rutrum quisque; morbi cras vulputate dictum. Sagittis aliquet rhoncus ultrices morbi aliquet habitasse sociis ac facilisis.',
                        ),
                      ),
                    ],
                  ),
                  // Repeat below for more questions
                  ExpansionTile(
                    title: Text('Question'),
                    children: [Text('Answer for the question goes here')],
                  ),
                  ExpansionTile(
                    title: Text('Question'),
                    children: [Text('Answer for the question goes here')],
                  ),
                  ExpansionTile(
                    title: Text('Question'),
                    children: [Text('Answer for the question goes here')],
                  ),
                  ExpansionTile(
                    title: Text('Question'),
                    children: [Text('Answer for the question goes here')],
                  ),
                  ExpansionTile(
                    title: Text('Question'),
                    children: [Text('Answer for the question goes here')],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
