import 'package:flutter/material.dart';
import 'package:bmi_tracker/features/log_in.dart';

void main() {
  runApp(
    MaterialApp(
      home: StartPage(), // StartPage
    ),
  );
}

class StartPage extends StatelessWidget {
  StartPage({Key? key}) : super(key: key);

  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Tracker'),
      ),
      body: Container(
        color: Colors.purple, // Purple background
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Body VitalityQuest', // Title
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: () {
                _navigateToLoginPage(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.orange), // Orange button
              ),
              child: Text('Get Started', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
