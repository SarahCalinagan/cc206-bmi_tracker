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
            Color.fromARGB(255, 192, 21, 192), // Set background color
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height:
                      75.0), // Move the text to the upper part (75% of the screen height)
              Text(
                'Body\nVitalityQuest', // Use line break to position the text
                style: TextStyle(
                  fontSize: 30, // Reduce the text size
                  fontWeight: FontWeight
                      .w900, // Use a high fontWeight for a chubby appearance
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0, // Increase the glow effect
                      color: Colors.white,
                    ),
                  ],
                ),
                textAlign: TextAlign.center, // Center the text horizontally
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
                  primary: Color(
                      0xFFFFA500), // Orange color in hexadecimal (#FFA500)
                  minimumSize: Size(160, 60.0), // Adjust button width
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0), // Add horizontal margin
                ),
              ),
              SizedBox(
                  height:
                      25.0), // Move the button to the lower part (25% of the screen height)
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
