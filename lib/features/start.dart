import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/features/log_in.dart';

class StartPage extends StatelessWidget {
  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Set background color
        color:
            Color.fromARGB(255, 16, 15, 94), // Replace with your desired color

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Large Image
              Image.asset(
                'assets/start.png', // Replace with the actual image path
                height: 300, // Set the desired height
                width: 300, // Set the desired width
              ),

              // SizedBox for spacing
              SizedBox(height: 20),

              // Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Body VitalityQuest',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),

              // SizedBox for spacing

              // Text Description
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 55.0),
                child: Text(
                  'Your Body Mass Index Wellness Tracking Adventure Navigating Your Health Journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Colors.white), // Text color
                ),
              ),

              // SizedBox for spacing
              SizedBox(height: 50),

              // Get Started Button
              ElevatedButton(
                onPressed: () {
                  _navigateToLoginPage(context);
                },
                child: Container(
                  width: 130,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 222, 96, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust the radius as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
