import 'package:flutter/material.dart';
import 'package:cc206_bmi_tracker/features/log_in.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key});

  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:
            Color(0xFF5F74D1), // Set the background color to #5F74D1
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 75.0),
              Stack(
                // Use a Stack to overlay the glowing text on top of the main text
                alignment: Alignment.center,
                children: [
                  Text(
                    'Body\nVitalityQuest',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Add a glowing outline around the text
                  Text(
                    'Body\nVitalityQuest',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.transparent,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToLoginPage(context);
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFA226), // Set the button color to #FFA226
                  minimumSize: Size(160, 60.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                ),
              ),
              SizedBox(height: 25.0),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: StartPage(),
    ),
  );
}
