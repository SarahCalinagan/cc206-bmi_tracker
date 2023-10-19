import 'package:flutter/material.dart';
import 'package:bmi_tracker/features/log_in.dart';

void main() {
  runApp(
    MaterialApp(
      home: StartPage(),
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
        decoration: BoxDecoration(
          color:
              Color(0xFFE6E6FA), // Lavender background using the hex color code
        ),
        child: Center(
          child: Container(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 100.0),
                Text(
                  'Body VitalityQuest',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _navigateToLoginPage(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                  child: Text('Get Started',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
